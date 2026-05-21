from __future__ import annotations

import logging
from typing import Any

import requests


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)


API_URL = "https://jsonplaceholder.typicode.com/posts"
REQUEST_TIMEOUT_SECONDS = 30


def extract_page(url: str, page: int = 1) -> list[dict[str, Any]]:
    """Extract one page of records from an API endpoint."""
    params = {
        "_page": page,
        "_limit": 100,
    }
    headers = {
        "Accept": "application/json",
    }

    logging.info("Requesting %s with params=%s", url, params)

    try:
        response = requests.get(
            url,
            params=params,
            headers=headers,
            timeout=REQUEST_TIMEOUT_SECONDS,
        )
        response.raise_for_status()
    except requests.Timeout as exc:
        logging.exception("API request timed out")
        raise RuntimeError("API request timed out") from exc
    except requests.HTTPError as exc:
        logging.exception("API returned HTTP status %s", response.status_code)
        raise RuntimeError(f"API returned HTTP status {response.status_code}") from exc
    except requests.RequestException as exc:
        logging.exception("API request failed")
        raise RuntimeError("API request failed") from exc

    data = response.json()
    if not isinstance(data, list):
        raise ValueError("Expected API response to be a JSON list")

    logging.info("Extracted %s records from page %s", len(data), page)
    return data


def extract_all_pages(url: str) -> list[dict[str, Any]]:
    """Extract records from all pages.

    This example uses a simple placeholder loop. Real APIs may return pagination
    metadata, next-page URLs, cursors, or response headers.
    """
    all_records: list[dict[str, Any]] = []
    page = 1

    while True:
        records = extract_page(url, page=page)
        if not records:
            break

        all_records.extend(records)

        # Pagination placeholder: adjust this condition for the real API.
        if len(records) < 100:
            break

        page += 1

    logging.info("Extracted %s total records", len(all_records))
    return all_records


def main() -> None:
    records = extract_all_pages(API_URL)
    logging.info("First record keys: %s", sorted(records[0].keys()) if records else [])


if __name__ == "__main__":
    main()
