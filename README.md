# README

## Installation
As a prerequisite, ensure you have Ruby on Rails, at least version 6:
```
$ rails -v
```

Perform the following steps after cloning the repository:
```
$ bundle install
$ rake db:migrate
```

## Session 1: API keys

### Setting third-party provider API keys
We have three sample APIs, each which requires a different key:
1. Address distance calculator: the distance between a given zip code and an address resource.
2. Get address info: show information about the zip code and city for a given address resource.
3. Validate social security number

You can set each in `config/application.rb` or as an environment variable:
* `config.address_calculate_distance_api_key` / `ADDRESS_CALCULATE_DISTANCE_API_KEY`
* `config.address_get_info_api_key` / `ADDRESS_GET_INFO_API_KEY`
* `config.ssn_validate_api_key` / `SSN_VALIDATE_API_KEY`

### Using the Strac proxy
By default, our application will call sample back-end APIs without the Strac proxy.

Set `config.use_strac_proxy` in `config/application.rb` or use the environment variable `USE_STRAC_PROXY`:
```
export USE_STRAC_PROXY=true
```

If you enable the Strac proxy, you need to protect the Strac API key by setting environment variable `STRAC_API_KEY`
before starting your server:
```
export STRAC_API_KEY=<api key value>
```

## Start local server
```
$ rails s
```
