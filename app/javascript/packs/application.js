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
      fetch(`/admin/providers/${cityId}.json`).
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

function showBeneficiaryOnNewShopping() {
  const element = document.querySelector('#new_shopping #shopping_beneficiary_id')
  const target = document.querySelector('#new_shopping #beneficiary-info .field-unit__field')
  if (element === undefined || element === null) {
    return
  }
  element.addEventListener('change', (event) => {
    const beneficiaryId = event.target.value
    if (beneficiaryId === undefined || beneficiaryId === '') {
      return
    }
    const params = new URLSearchParams
    params.set('fragment', true)
    fetch(`/admin/beneficiaries/${beneficiaryId}.html?${params.toString()}`).
      then((data) => data.text()).
      then((text) => target.innerHTML = text)
    const targetProviderElement = document.querySelector('#new_shopping #shopping_provider_id')
    fetch(`/admin/beneficiaries/${beneficiaryId}.json`).
      then((data) => data.json()).
      then((json) => targetProviderElement.value = json.provider_id)
  })
}

function cartCategoryButton() {
  const element = document.querySelector('[data-shopping-category]')
  if (element === undefined || element === null) {
    return
  }
  const itemsContainer = document.querySelector('[data-items-container]')
  element.addEventListener('change', (event) => {
    const itemCategoryId = event.target.value
    if (itemCategoryId === undefined || itemCategoryId === '') {
      return
    }
    const params = new URLSearchParams
    params.set('item_category_id', itemCategoryId)
    params.set('inputs', true)
    fetch(`/admin/warehouse_items.html?${params.toString()}`).
      then((data) => data.text()).
      then((text) => itemsContainer.innerHTML = text)
  })
}

updateCityOnProviderSelection()
showBeneficiaryOnNewShopping()
cartCategoryButton()
