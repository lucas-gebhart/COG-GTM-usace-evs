from datetime import datetime, timedelta, timezone

from botocore.stub import Stubber

from evs.ingest.archive import RawArchive


def test_key_layout_is_utc():
    when = datetime(2026, 10, 6, 9, 26, 17, tzinfo=timezone(timedelta(hours=-5)))
    assert (
        RawArchive.key("lpms", "lock_status_report", when) == "lpms/lock_status_report/20261006T142617Z.json"
    )


def test_put_creates_bucket_once_and_is_best_effort():
    archive = RawArchive("http://minio.local:9000", "evs-raw", "k", "s")
    assert archive.enabled
    with Stubber(archive._client) as stub:
        stub.add_client_error("head_bucket", "404")
        stub.add_response("create_bucket", {}, {"Bucket": "evs-raw"})
        stub.add_response(
            "put_object",
            {},
            {
                "Bucket": "evs-raw",
                "Key": "lpms/x/20261006T000000Z.json",
                "Body": b"{}",
                "ContentType": "application/json",
            },
        )
        stub.add_client_error("put_object", "InternalError")
        assert archive.put("lpms/x/20261006T000000Z.json", "{}")
        assert archive.last_error is None
        assert not archive.put("lpms/y/20261006T000000Z.json", "{}")
        assert archive.last_error and "InternalError" in archive.last_error


def test_disabled_without_endpoint_or_keys():
    archive = RawArchive(None, "evs-raw", None, None)
    assert not archive.enabled and archive.put("k", "v") is False
