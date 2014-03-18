# Authorization API

## Usage

Access API by sending `POST` request to `/users/authorize.json` path with `JSON` string as request body.

Example of JSON:

    {
      "name": "John Doe",
      "email": "john@doe.com", 
      "password": "s3kr3t", 
      "password_confirmation": "s3kr3t" 
    }

As a response you will get `JSON`:

    {
      "id": 1,
      "name": "JohnDoe",
      "email": "john@doe.com", 
      "authentication_token": "s3kr3t-value" 
    }

If an input is not valid, you will get `401` status code.