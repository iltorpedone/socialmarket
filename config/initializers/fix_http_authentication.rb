# Fixes [CVE-2021-22885](https://github.com/advisories/GHSA-hjg4-8q5f-x6fm)
module ActionController::HttpAuthentication::Token
  AUTHN_PAIR_DELIMITERS = /(?:,|;|\t)/
end
