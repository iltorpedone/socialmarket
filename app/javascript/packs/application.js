/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

function updateCityOnProviderSelection() {
  const element = document.querySelector('#beneficiary_provider_id')
  const target = document.querySelector('#beneficiary_city_id')
  if (element === undefined || element === null) {
    return
  }
  element.addEventListener('change', (event) => {
    const cityId = event.target.value
    if (cityId !== undefined && cityId !== '') {
      fetch(`/admin/providers/${cityId}/show_json`).
        then((data) => data.json()).
        then((json) => {
          const providerCityId = json.city_id
          if (providerCityId !== null) {
            target.value = providerCityId
          }
        })
    }
  })
}

updateCityOnProviderSelection()
