# This is a list of TODOs for lordcore

[x] make sure things like GA and airbrake aren't running in test/dev modes

[ ] separate property managers from 1-1 relationship with company

[ ] pics on everyone's profiles

[x] resource for PMs to get all their income from rent?
  * maybe a nice JS table like all the other
  * filterable, etc...
  * export the filtered set to CSV or something. email it out, or w/e
  * also handle expenses with this

[x] private github organization for repository (dev account -> prvate)

[x] notify when user makes payment on lease
  * maybe show that a new payment has been made
  * send out an email to property managers

[ ] make lease creation and discovery easier
  * currently its locked behind units. should be a bit more in-the-open

[ ] better information on the fee when a user looks at pending funds on their finances page
  * also some JS to display the fee when a PM is creating a lease for tenants

[x] flesh out the residents view in property manager portal

[ ] clean up all errors/warnings from react

[ ] maybe some jest/specs or enzyme or whatever the hell the cool kids use these days

[ ] handle debounce-ness on the issue creation form

[x] show more granular information to a property manager on the residency show
page. something like, when they were invited, emails that have been sent to
them, etc...

[ ] issue creation for property managers.

[ ] make chat messages its own component so it looks the same from chat to chat
:)

[ ] shallow routes

[ ] lease payments for tenant/manager view need shared partials for the shared
stuff


[x] issues: need a few things
 * paginate the table
 * make sorting/filtering hit server-side. so a user can copy+paste the table
 * optionally -- save filters for later use?

[ ] handle webhooks in production. need the CSRF section in stripe docs

[x] Paginate the tables. you shouldn't have more than X records on one table

[ ] Multi step form for lease. Just makes sense

[ ] Month-to-month leases
 * maybe need to make a special kind of lease with no end. and you just run a
   cron job that updates these leases with more lease payments. every 6 months?

[x] NOTIFICATIONS
 * notify users on a per-unit and per-property basis
 * maybe this is very similar to chat?????
    * yes, you can hit people with notifications in actioncable
 * maybe notifications rely on events.
 * potentially: for every unit in a property, you create a new chat message.
   Then all units and tenants can see a property-wide message. and can respond
   in their own self-contained tenant/unit chat to property management.

[x] CHAT
 * on a per unit basis. would be nice to have chats with tenants. They can get
*this should be handled for now. may not need anything else around this*
   updates/alerts/etc...
 * all tenants in a unit can see a chat, and can chat with property management
 * chat is only visible to management, and residents of a particular unit. If a
   new resident joins, they can't view the past chats...
  * what does this mean? Do we create a new record for only tenants in a current
    unit? or do we timestamp these messages, and depending on residency
    creation, only allow residents to see certain thigns? hmm...
    * yeah. create chats only to residents in a unit. Then residents can only
      see their chats. and not chats for any other resident... that makes sense

[x] Banking Information
 * need better TOS and better information around the banking information

[x] Bank lifecycle
 * handle displaying when funds get transferred to bank account

[x] Property Manager Home Page
 * handle all links on the first page. Actually be able to edit the things I say
   you can edit.

[x] EVENTS
 * need events so managers can see what is going on with their property.
 * CRUD actions on all models for events
 * type == CRUD stuff
 * eventable fucking ... ... polymorphic association for all things

[x] make a nice stepper for creating a property.
 * maybe only do this for a first property? Either way, would be nice.
 * think of ways to gamify this, make a list that displays differently when you
   finished the step?
 * maintain a very small barrier to entry. don't just display a massvie list of
   TODOs to a person. might be overwhelming
*this should be handled for now. may not need anything else around this*

[x] get more information to tables displaying transactions.
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

## Little bugzzz to fix
 *small things that need to be fixed but aren't completely dealbreakers*
[x] refactor the duplication in residencies controllers
 * property/residencies and property/units/residencies
 * some of the stuff in these should be refactored out into service object(s)

[x] chat scrolls down too far
 * need to fix the small thing with the scrolling to the last LI. not sure yet.

## Smaller Stuff!
 *stuff that wont take as much time to do. and are mostly just bugs or refactors.*

[x] Links in property management nav
 * currently there is nothing there and is a joke

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
