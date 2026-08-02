# Authenticating requests

To authenticate requests, include an **`Authorization`** header with the value **`"Bearer {YOUR_TOKEN}"`**.

All authenticated endpoints are marked with a `requires authentication` badge in the documentation below.

Get your token from the <b>/api/register</b> or <b>/api/login</b> endpoints and send it as a Bearer token.
