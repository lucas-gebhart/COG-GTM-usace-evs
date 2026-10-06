# GovCloud IL5 reference architecture (Terraform, code only)

This directory expresses section 3 of `docs/PLAN.md` as Terraform so the design can be reviewed, linted and
validated like application code. **It has not been applied anywhere and must not be applied as part of the
demo.** CI runs `terraform fmt -check`, `terraform init -backend=false` and `terraform validate` only. There is
no backend block and no state.

## What "IL5" means here, and what it does not

- Every AWS service used is listed with an **IL5 (GovCloud)** checkmark on the AWS DoD Cloud Computing SRG
  services-in-scope page (https://aws.amazon.com/compliance/services-in-scope/DoD_CC_SRG/, page dated
  October 05, 2026, checked 2026-10-06; screenshots in `docs/research/evidence_aws_dod_il5_aurora_rds.png`
  and `docs/research/evidence_aws_dod_il5_rds_rows.png`, table in `docs/research/evs_architecture_report.md`
  section 2.1).
- That checkmark is a **service-level DISA Provisional Authorization**. It says the AWS service sits inside
  DISA's PA boundary. It says nothing about EVS. **EVS would still need its own RMF assessment and ATO inside
  the USACE/Army boundary**, inheriting controls from AWS GovCloud where the SSP allows. Nothing in this
  repository is an authorization artefact.
- **Amazon CloudFront is excluded.** It carries IL2 (East/West) only on the AWS table, so there is no CDN in
  this design; the ALB terminates TLS and nginx serves the static React build and the PMTiles basemap.
- This is a demo. The Fly.io deployment in `infra/fly` is the only running environment.

## Services and how they were verified

| Service (module) | AWS DoD CC SRG row | IL5 GovCloud | Used for |
|---|---|---|---|
| Amazon Aurora PostgreSQL (`aurora-postgresql`) | Amazon Aurora PostgreSQL | Yes | PostgreSQL 17 cluster with PostGIS, KMS encryption, managed master password |
| Amazon RDS for PostgreSQL (alternative) | Amazon RDS for Postgres | Yes | Same engine if Aurora is not wanted; same PostGIS extension list |
| Amazon ECS / ECR (`ecs`) | Amazon ECS / ECR | Yes | Fargate services web and api, ingest task definition, KMS-encrypted image repositories |
| Application Load Balancer (`ecs`) | Elastic Load Balancing | Yes | Path routing `/api/*` to api, everything else to web; FIPS TLS policy |
| AWS WAF (`ecs`) | AWS WAF (wafv2) | Yes | Managed common and known-bad-inputs rule groups plus per-IP rate limit |
| Amazon EventBridge Scheduler (`scheduler`) | Amazon EventBridge | Yes | Runs the ingest task every 15 minutes |
| Amazon Cognito (`cognito`) | Amazon Cognito | Yes | User pool, app client, OIDC identity provider placeholder for Army ICAM |
| Amazon S3 (`s3`) | Amazon S3 | Yes | Raw feed drops bucket and PMTiles bucket, KMS, versioning, TLS-only policy |
| AWS Secrets Manager (`aurora-postgresql`, `ecs`) | AWS Secrets Manager | Yes | RDS managed master password, read by the task execution role |
| Amazon CloudWatch (`observability`, `ecs`) | Amazon CloudWatch | Yes | KMS-encrypted log groups, alarms, dashboard |
| AWS KMS (all) | AWS Key Management Service | Yes | Customer managed keys for Aurora, S3, logs, SNS |
| Amazon VPC and PrivateLink endpoints (`network`) | Amazon VPC | Yes | Private subnets, endpoints for S3, ECR, Secrets Manager, CloudWatch Logs |
| Amazon CloudFront | Amazon CloudFront | **No (IL2 East/West only)** | Excluded |

Verification method: the services-in-scope page was loaded in a browser on 2026-10-06, the IL5 (GovCloud)
column was read for each row above and the Aurora/RDS rows were captured as screenshots. Rows not shown in the
screenshots were read from the same page on the same day. Re-check the page before any customer conversation;
AWS updates it monthly.

## Layout

```
infra/terraform-govcloud/
  versions.tf  providers.tf  variables.tf  main.tf  outputs.tf  terraform.tfvars.example
  modules/
    network/            VPC, 2 AZ public + private subnets, optional NAT, gateway endpoint for S3,
                        interface endpoints for ECR (api, dkr), Secrets Manager, CloudWatch Logs
    aurora-postgresql/  Aurora PostgreSQL 17, Serverless v2 or provisioned (db.r6g.large), KMS, cluster
                        parameter group, Secrets Manager managed password, PostGIS notes
    ecs/                ECS cluster, ECR repositories, task and execution roles, ALB + WAFv2, Cloud Map,
                        task definitions web/api/ingest, services web/api
    scheduler/          EventBridge Scheduler schedule and role that runs the ingest task
    cognito/            User pool, domain, app client, optional OIDC identity provider (Army ICAM placeholder)
    s3/                 Raw drops and PMTiles buckets
    observability/      Logs KMS key, SNS alarm topic, ALB and Aurora alarms, dashboard
```

Same images, same environment variable names as `infra/compose` and `infra/fly`; see the mapping table in
`infra/compose/README.md`.

## PostGIS on Aurora

`CREATE EXTENSION postgis` is supported on Aurora PostgreSQL and RDS for PostgreSQL without any parameter
group change (the extension is on the supported list and is created by `db/migrations/0001_extensions.sql`,
the same migration that runs locally). The cluster parameter group in `modules/aurora-postgresql` sets
`rds.force_ssl=1`, `log_statement=ddl` and `shared_preload_libraries=pg_stat_statements,pg_partman_bgw`; the
PostGIS notes are in comments next to it.

## Validate locally

```
make tf-validate
# or
cd infra/terraform-govcloud && terraform init -backend=false -input=false && terraform validate
```

Do not run `terraform plan` or `terraform apply` for this demo. If a plan is ever wanted, it needs GovCloud
credentials and an `aws_acm_certificate` for `alb_certificate_arn`; with the certificate variable left empty the
ALB listens on HTTP only, which is for validation convenience and not a deployable posture.

## Indicative monthly cost (us-gov-west-1, list prices, always-on, before any discount)

| Item | Sizing | Approx. per month |
|---|---|---|
| Aurora PostgreSQL | 1 x db.r6g.large ($0.313/hr) or Serverless v2 0.5 to 4 ACU | 230 to 260 |
| ECS Fargate | web 2 x 0.25 vCPU/0.5 GB, api 2 x 0.5 vCPU/1 GB, ingest 15 minute runs | 60 to 80 |
| ALB + WAF | 1 ALB, 1 web ACL, 3 rules | 45 to 60 |
| NAT gateway | 1, light egress for feeds | 40 to 50 |
| VPC interface endpoints | 5 endpoints x 2 AZ | 80 to 90 |
| S3, Secrets Manager, CloudWatch, KMS, Cognito | small | 20 to 40 |
| **Total** | | **roughly 500 to 600** |

Figures are for framing only; GovCloud prices run above commercial and the customer's EA pricing applies.
Compare with the Fly.io demo at roughly 25 to 35 per month (see `infra/fly/README.md`).
