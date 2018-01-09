# This is a list of TODOs for lordcore

## Big Stuff!
 *things that will take a while to do, but really need to be done and are essential.*

[ ] make a nice stepper for creating a property.
 * maybe only do this for a first property? Either way, would be nice.
 * think of ways to gamify this, make a list that displays differently when you
   finished the step?
 * maintain a very small barrier to entry. don't just display a massvie list of
   TODOs to a person. might be overwhelming

[ ] get more information to tables displaying transactions.
 * Get more information into the objects that store local transactions.
 * clicking on a table row will pop up a modal displaying the current status
   from stripe perhaps? or not.
 * set up web hooks from stripe to update the statuses for payments, etc...
 * use pills not checkmarks in the tenant lease info section

 *REALLY BIG ONE*
[x] HANDLE CURRENCY.
 * everything needs to be stored in cents. All transactions happen with cents
   not dollars. currently that is not the case.


[x] Create properties/units for property managers to.... manage
[x] Create login portal for users.
[x] Allow users to store ACH information through plaid and stripe (example app
for this)
[x] Set up recurring payments so users can pay rent to property manager's
company

## Smaller Stuff!
 *stuff that wont take as much time to do. and are mostly just bugs or refactors.*

[x] add simple_form with bootstrap initializer for form stuff
* this will make everything look 1 million x better in forms

[x] re-do the editing of a stripe account
* This is currently pretty terrible. and is just copy+pasted from the original
  thing

[x] refactor stripe account stuff into services
  *kinda done*
* I think the current code isn't bad. but should be pushed into services if
  possible and out of the controller if we can do that. I think that would
  just make the code that much more readable


[x] Create dashboard for each property for payments, etc...
* this should be pretty straightforward. Copy the stuff from example stripe app
  and modify it to our needs.
    * create a charge using ruby stripe api
    * assign charge to property/unit
    * store charge guid on model to retrive later (and to use for refunds,
      etc..)
