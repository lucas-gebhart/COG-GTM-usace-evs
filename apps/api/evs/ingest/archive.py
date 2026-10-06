"""Raw payload archival to S3 / MinIO. Best effort: a failed PUT is logged and never fails the cycle."""

import logging
from datetime import UTC, datetime

log = logging.getLogger(__name__)


class RawArchive:
    def __init__(
        self,
        endpoint: str | None,
        bucket: str,
        access_key: str | None,
        secret_key: str | None,
        region: str = "us-gov-west-1",
    ) -> None:
        self.bucket = bucket
        self.enabled = bool(endpoint or access_key)
        self._client = None
        self._bucket_checked = False
        self.last_error: str | None = None
        if not self.enabled:
            return
        try:
            import boto3
            from botocore.config import Config

            self._client = boto3.client(
                "s3",
                endpoint_url=endpoint,
                region_name=region,
                aws_access_key_id=access_key,
                aws_secret_access_key=secret_key,
                config=Config(
                    connect_timeout=3,
                    read_timeout=10,
                    retries={"max_attempts": 1},
                    s3={"addressing_style": "path"},
                ),
            )
        except Exception as exc:  # noqa: BLE001
            self.last_error = f"archive disabled: {exc}"
            log.warning(self.last_error)
            self.enabled = False

    @staticmethod
    def key(feed: str, endpoint: str, when: datetime, ext: str = "json") -> str:
        return f"{feed}/{endpoint}/{when.astimezone(UTC).strftime('%Y%m%dT%H%M%SZ')}.{ext}"

    def put(self, key: str, body: str | bytes, content_type: str = "application/json") -> bool:
        if not self.enabled or self._client is None:
            return False
        data = body.encode() if isinstance(body, str) else body
        try:
            if not self._bucket_checked:
                try:
                    self._client.head_bucket(Bucket=self.bucket)
                except Exception:  # noqa: BLE001
                    self._client.create_bucket(Bucket=self.bucket)
                self._bucket_checked = True
            self._client.put_object(Bucket=self.bucket, Key=key, Body=data, ContentType=content_type)
            self.last_error = None
            return True
        except Exception as exc:  # noqa: BLE001
            self.last_error = f"archive put {key} failed: {type(exc).__name__}: {exc}"[:500]
            log.warning(self.last_error)
            return False
