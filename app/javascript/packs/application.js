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

class Cart {
  constructor({ container }) {
    this.container = container
    this.setDefaults()
    this.domElements = {
      categoryInput: this.container.querySelector('[data-cart-category-input]'),
      itemsCountView: this.container.querySelector('[data-cart-items-count-view]'),
      priceView: this.container.querySelector('[data-cart-price-view]'),
      quantityView: this.container.querySelector('[data-cart-quantity-view]'),
      itemsContainer: this.container.querySelector('[data-cart-items-container]'),
    }
    this.setupCategoryInput()
    this.setupItemsChanges()
  }

  toPrice(value) {
    return Number.parseFloat(value)
  }

  formatPrice(value) {
    return Number.parseFloat(value).toFixed(2)
  }

  toQuantity(value) {
    const quantity = Number.parseInt(value, 10)
    return Number.isNaN(quantity) ? 0 : quantity
  }

  setDefaults() {
    const { price, quantity, itemsCount } = this.container.dataset
    this.price = this.toPrice(price)
    this.quantity = this.toQuantity(quantity)
    this.baseItemsCount = this.toQuantity(itemsCount)
    this.itemsCount = 0
    this.items = {}
  }

  reset() {
    this.setDefaults()
    this.updateViews()
  }

  setupCategoryInput() {
    const self = this
    this.domElements.categoryInput.addEventListener('change', (event) => {
      const itemCategoryId = event.target.value
      if (itemCategoryId === undefined || itemCategoryId === '') {
        return
      }
      const params = new URLSearchParams
      params.set('item_category_id', itemCategoryId)
      params.set('inputs', true)
      fetch(`/admin/warehouse_items.html?${params.toString()}`).
        then((data) => data.text()).
        then((text) => {
          self.domElements.itemsContainer.innerHTML = text
          self.reset()
        })
    })
  }

  setupItemsChanges() {
    this.domElements.itemsContainer.addEventListener(
      'change',
      this.updateCartRowByInput.bind(this)
    )
    this.domElements.itemsContainer.addEventListener(
      'keyup',
      this.updateCartRowByInput.bind(this)
    )
  }

  updateCartRowByInput(event) {
    const element = event.target
    const data = element.dataset
    if (data.quantityInput !== 'true') {
      return
    }
    let quantity = this.toQuantity(element.value)
    const price = this.toPrice(data.unitaryAmount) * quantity
    const priceView = element.parentElement.parentElement.querySelector('[data-price-view]')
    priceView.innerHTML = this.formatPrice(price)
    const id = element.dataset.id
    // price is passed just to speed up calculations
    this.setItem({ id, quantity, price })
    this.updateTotals()
    this.updateViews()
  }

  setItem({ id, quantity, price }) {
    const isPresent = Object.keys(this.items).indexOf(id) !== -1
    if (quantity === 0) {
      delete(this.items[id])
      return
    }
    this.items[id] = {
      quantity,
      price,
    }
  }

  updateTotals() {
    values = Object.values(this.items)
    this.quantity = values.
      map((item) => item.quantity).
      reduce((memo, current) => memo + current, 0)
    this.price = values.
      map((item) => item.price).
      reduce((memo, current) => memo + current, 0)
    this.itemsCount = this.baseItemsCount + values.length
  }

  updateViews() {
    this.domElements.priceView.innerHTML = this.formatPrice(this.price)
    this.domElements.quantityView.innerHTML = this.quantity
    this.domElements.itemsCountView.innerHTML = this.itemsCount
  }
}

function setupCart() {
  const container = document.querySelector('[data-cart]')
  if (container === undefined || container === null) {
    return
  }
  const cart = new Cart({ container })
}

updateCityOnProviderSelection()
showBeneficiaryOnNewShopping()
setupCart()
