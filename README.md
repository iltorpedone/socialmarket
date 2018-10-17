# Social Market

https://socialmarket-it.herokuapp.com

## TODO

- [x] Add the relation between users and providers
- [x] remove the field `extended_at` from `Beneficiary`
- [ ] when a `Provider` creates a new `Beneficiary`, a confirmation e-mail is sent to the administrators. The newly created record is not active, yet. The e-mail contains a link to the page where the administrator can either confirm or deny the creation. If the administrator denies the creation, then the newly created record gets deleted. If the administrator confirms the creation, then the newly created record becomes active.
  - [ ] add `active` to `beneficiary`. It's a boolean attribute that defaults to `false`
  - [ ] confirmation e-mail
  - [ ] confirmation page
- [ ] when a `Provider` updates a `Beneficiary`'s `proposed_max_shop_count` field, a confirmation e-mail is sent to the administrators. The e-mail contains a link to the page where the administrator can either confirm or deny the variation. If the administrator confirms the variation, then `proposed_max_shop_count` is reset to `nil` and `max_shop_count` gets updated to the proposed value. If the administrator denies the variation, `proposed_max_shop_count` is reset to `nil`.
  - [ ] add `proposed_max_shop_count` to `Beneficiary`
  - [ ] confirmation e-mail
  - [ ] confirmation page
- [ ] Configure the domain https://www.socialmarketnordmi.org
- [ ] when creating a `Provider`, provide the following fields:
  - telephone
  - email
  - referent
  - address
  - city
- [ ] User creation:
  - [ ] When the administrator creates a `User`, he doesn't specify the `password`.
  - [ ] A new user is not active by default.
  - [ ] After the administrator create a `User`, an e-mail is sent to the user's e-mail address, containing a signup link that when opened by anyone allows **just** the completion of the signup.
  - [ ] Once the user completes their profile, a confirmation e-mail is sent to the administrators.
  - [ ] Once an administrator confirms the user, the user is able to login.
- [ ] Once a user is created, their role cannot be modified.
- [ ] Soft deletion of users:
  - [ ] deleted:boolean defalt=false
- [ ] when creating a new `Beneficiary`, once a `Provider` is selected, populate the `city` field using `Provider.city`.
- [ ] Beneficiary: split `full_name` in `first_name` and `last_name`
- [ ] Beneficiary: add `gender: Enum(male|female)`
- [ ] Beneficiary: remove `contribution`
- [ ] Beneficiary: remove `current_shop_count`
- [ ] Beneficiary: make `current_shop_count` a computed value
- [ ] Beneficiary: convert `frequency` into an enum: `weekly, half-monthly, monthly`
- [ ] Beneficiary: convert `family_size` into multiple integer fields, each of them presented as a drop down with `0..15` as the available range:
  - `family_components_count_0_1`
  - `family_components_count_2_5`
  - `family_components_count_6_12`
  - `family_components_count_13_18`
  - `family_components_count_19_30`
  - `family_components_count_30_65`
  - `family_components_count_over_65`
- [ ] `Shopping::new`
  - [ ] remove the string "beneficiario" from the names of each `Beneficiary`.
  - [ ] autocomplete the name of the `Beneficiary` #evolutive
  - [ ] when selecting a `Beneficiary`, shows their info
  - [ ] remove `code`
  - [ ] after the shopping has been created, redirect to the page to add new shopping items
- [ ] new shopping items:
  - [ ] in the new shopping items page show the info about the `Beneficiary` and the updated stats of the current `Shopping`, showing the shopping's grand total (initially set to € 0)
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
- [ ] warehouse items index page:
  - [ ] rename `price` into `unitary_amount`
  - [ ] rename `code` into `name`
  - [ ] order by `item_category.name`, `name`
  - [ ] remove `description`
- [ ] Close shopping:
  - [ ] in new shopping items, add a "soft close" button that once clicked, just sets a `soft_closed` field
  - [ ] in the shopping index and show pages:
    - [ ] show a "hard close" button that, once clicked, makes it impossible to reopen the shopping list
    - [ ] is the shopping is “soft closed“ then show a "re-open" button that once clicked allows the edit of the shopping items
- [ ] in new shopping items
  - [ ] add a "category" select that filters all the products belonging to the selected category
  - [ ] allows the creation inline of a new product belonging to the selected category
- [ ] create a better style for the login page
