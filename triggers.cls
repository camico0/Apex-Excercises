/*Triggers
Create a Trigger and handler that runs on Offer and another for Property (use the same
a) Create a method inside a Trigger that update the Available field to “Unchecked” (false), when
an offer Status is changed to Closed (runs after update & after insert)
b) Create a method inside a Trigger that update all the Offers from one property to Rejected 
when a Property is changed from Available “true” to “false”, do not modify a Closed Offer. (runs after 
update)
