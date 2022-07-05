/*Triggers
Create a Trigger and handler that runs on Offer and another for Property (use the same
a) Create a method inside a Trigger that update the Available field to “Unchecked” (false), when
an offer Status is changed to Closed (runs after update & after insert)*/

trigger offerTrigger on Offer__c (after insert, after update) {
    
    if(Trigger.isInsert || Trigger.isUpdate){
        offerTriggerHandler.availabilityChecker();
    }
    
}

//-----------------------------------------------------------------------

//HANDLER CLASS:


public class offerTriggerHandler {
    
    public static void availabilityChecker(){
        List<Offer__c> offers = [SELECT Property__r.id, name FROM Offer__c WHERE status__c = 'Closed'];
        set<id> pptyid = new set<id>();
        
        
        for(Offer__c o : offers){
            pptyid.add(o.Property__r.id);
        }
        
        List<Property__c> ppty = [SELECT name, id FROM Property__c WHERE ID IN :pptyid];
        
        for(Property__c p : ppty){
            p.Available__c = False;
        }
        
        update ppty;
    }
}


/*b) Create a method inside a Trigger that update all the Offers from one property to Rejected 
when a Property is changed from Available “true” to “false”, do not modify a Closed Offer. (runs after 
update)*/


