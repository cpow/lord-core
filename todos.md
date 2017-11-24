# This is a list of TODOs for lordcore

## Big Stuff!
 *things that will take a while to do, but really need to be done and are essential.*

[ ] Create properties/units for property managers to.... manage
[ ] Create login portal for users.
[ ] Allow users to store ACH information through plaid and stripe (example app
for this)
[ ] Set up recurring payments so users can pay rent to property manager's
company

## Smaller Stuff!
 *stuff that wont take as much time to do. and are mostly just bugs or refactors.*

[ ] add simple_form with bootstrap initializer for form stuff
* this will make everything look 1 million x better in forms

[ ] re-do the editing of a stripe account
* This is currently pretty terrible. and is just copy+pasted from the original
  thing

[ ] refactor stripe account stuff into services
* I think the current code isn't bad. but should be pushed into services if
  possible and out of the controller if we can do that. I think that would
  just make the code that much more readable


[ ] Create dashboard for each property for payments, etc...
* this should be pretty straightforward. Copy the stuff from example stripe app
  and modify it to our needs.
    * create a charge using ruby stripe api
    * assign charge to property/unit
    * store charge guid on model to retrive later (and to use for refunds,
      etc..)
