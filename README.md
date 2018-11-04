# Social Market

https://socialmarket-it.herokuapp.com

## Seed administrators

```
heroku run rails console
User.create(
  full_name: 'Elliot Alderson',
  email: 'elliot@fsociety.org',
  password: 'Mr.Robot',
  app_role: :administrator,
  is_active: true,
)
```

## TODO

- [x] Add the relation between users and providers
- [x] remove the field `extended_at` from `Beneficiary`
- [x] when a `Provider` creates a new `Beneficiary`, a confirmation e-mail is sent to the administrators. The newly created record is not active, yet. The e-mail contains a link to the page where the administrator can either confirm or deny the creation. If the administrator denies the creation, then the newly created record gets deleted. If the administrator confirms the creation, then the newly created record becomes active.
  - [x] add `active` to `beneficiary`. It's a boolean attribute that defaults to `false`
  - [x] show only active beneficiaries when creating a new shopping
  - [x] Allow the edit of the active status
  - [x] beneficiary creation form
  - [x] confirmation e-mail
  - [x] confirmation page
- [ ] A `Provider` can see only its beneficiaries.
  - [x] When creating a new shopping
  - [ ] TODO: enumerate other occurrences
- [x] when a `Provider` updates a `Beneficiary`'s `proposed_max_shop_count` field, a confirmation e-mail is sent to the administrators. The e-mail contains a link to the page where the administrator can either confirm or deny the variation. If the administrator confirms the variation, then `proposed_max_shop_count` is reset to `nil` and `max_shop_count` gets updated to the proposed value. If the administrator denies the variation, `proposed_max_shop_count` is reset to `nil`.
  - [x] add `proposed_max_shop_count` to `Beneficiary`
  - [x] confirmation e-mail
  - [x] confirmation page
- [ ] Configure the domain www.socialmarketnordmi.org
- [ ] Configure the TLS certificate
- [x] when creating a `Provider`, provide the following fields:
  - telephone
  - email
  - referent
  - address
  - city
- [x] User creation:
  - [x] When the administrator creates a `User`, he doesn't specify the `password`.
  - [x] A new user is not active by default.
  - [x] After the administrator create a `User`, an e-mail is sent to the user's e-mail address, containing a signup link that when opened by anyone allows **just** the completion of the signup.
  - [x] Once the user completes their profile, a confirmation e-mail is sent to the administrators.
  - [x] Once an administrator confirms the user, the user is able to login.
- [x] Once a user is created, their role cannot be modified.
- [x] Soft deletion of users:
  - [x] deleted:boolean defalt=false
- [x] when creating a new `Beneficiary`, once a `Provider` is selected, populate the `city` field using `Provider.city`.
- [x] Beneficiary: split `full_name` in `first_name` and `last_name`
- [x] Beneficiary: add `gender: Enum(male|female)`
- [x] Beneficiary: remove `contribution`
- [x] Beneficiary: remove `current_shop_count`
- [x] Beneficiary: make `current_shop_count` a computed value
- [x] Beneficiary: convert `frequency` into an enum: `weekly, half-monthly, monthly`
- [x] Beneficiary: convert `family_size` into multiple integer fields, each of them presented as a drop down with `0..15` as the available range:
  - `family_components_count_0_1`
  - `family_components_count_2_5`
  - `family_components_count_6_12`
  - `family_components_count_13_18`
  - `family_components_count_19_30`
  - `family_components_count_30_65`
  - `family_components_count_over_65`
- [x] Beneficiary: create a `family_size` with the sum of all the `family_components_*`
- [ ] `Shopping::new`
  - [x] remove the string "beneficiario" from the names of each `Beneficiary`.
  - [ ] autocomplete the name of the `Beneficiary` #evolutive
  - [x] when selecting a `Beneficiary`, shows their info
  - [x] remove `code`
  - [x] when a beneficiary is selected, set the corresponding provider
  - [x] after the shopping has been created, redirect to the page to add new shopping items
- [x] warehouse items index page:
  - [x] rename `price` into `unitary_amount`
  - [x] rename `code` into `name`
  - [x] order by `item_category.name`, `name`
  - [x] remove `description`
- [ ] new shopping items:
  - [x] in the new shopping items page show the info about the `Beneficiary` and the updated stats of the current `Shopping`, showing the shopping's grand total (initially set to € 0)
  - [ ] dynamic add
    ```
      [ pasta ] -> categoria

      // sono ordinati per nome
      - fusilli    [ 3 ] ( scorta disponibile ) ( prezzo unitario ) --> ( prezzo totale calcolato al change della quantità )
      - spaghetti  [ 6 ] ( scorta disponibile ) ( prezzo unitario ) --> ( prezzo totale calcolato al change della quantità )
      - tortellini [   ] ( scorta disponibile ) ( prezzo unitario ) --> ( prezzo totale calcolato al change della quantità )

      // prezzo unitario è in sola lettura e recuperato dal prodotto
      // prezzo totale in sola lettura e calcolato on change

      ogni modifica onchange ricalcola il nuovo totale della spesa mostrato in cima

      [ aggiungi ]
    ```
    - [x] add a category select that performs a json request
    - [ ] json response: for each item render an input row
    - [ ] input rows: when the amount changes, update the row total and the current shopping total
    - [ ] add button perform a post request that persists the items with quantity > 0
    - [ ] the add action completes by reloading the page
    - [ ] for each item in the current shopping, show the code, quantity, total, category and a delete button
    - [ ] the delete action reloads the page
- [ ] Close shopping:
  - [ ] in new shopping items, add a "soft close" button that once clicked, just sets a `soft_closed` field
  - [ ] in the shopping index and show pages:
    - [ ] show a "hard close" button that, once clicked, makes it impossible to reopen the shopping list
    - [ ] is the shopping is “soft closed“ then show a "re-open" button that once clicked allows the edit of the shopping items
- [ ] in new shopping items
  - [ ] add a "category" select that filters all the products belonging to the selected category
  - [ ] allows the creation inline of a new product belonging to the selected category
- [ ] create a better style for the login page
- [ ] create a better style for the beneficiary confirmation page
- [ ] create a better style for the beneficiary's max shop count confirmation page
- [ ] Avoid hardcoded routes in JS
