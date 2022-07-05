/*Junction Objects

/*a) Create a Class called ManageOffers, there create a method called BestOffer the method 
recieves a Property ID and it reruns the best offer. (highest Amount)*/

public class ManageOffers {
    
    public static Offer__c BestOffer(id ppID) {
       
        Offer__c MaxOffer = [SELECT id, Ammount__c, Buyer__c, Name, Property__c, Status__c, Type__c
                            FROM Offer__c WHERE Offer__c.property__c = :ppID ORDER BY Ammount__c DESC][0];
        return MaxOffer;
    }


/*b) Create a method called GetBestBuyers who receives an Integer and returns a list of the 
contact with equal or more offers than that number, if 0 is provided will return null*/

public static List<Contact> GetBestBuyers(integer c){
        
        //Create a list to hold the different offers with associated Buyer
        //Create a list to save the ID of Buyer that needs to return 
        //Also create a list of contact for return that is filter in a query by the list of ID 
        
        List<Offer__c> OfferList = [SELECT Offer__c.ID, Offer__c.Buyer__r.ID, Offer__c.Buyer__r.FirstName, Offer__c.Buyer__r.LastName FROM Offer__c];
        List<Id> result = new List<Id>();
        List<Contact> resultCont = [SELECT AccountID, FirstName, LastName FROM Contact WHERE id IN :result LIMIT 200];
             
        //We create a map that contains ID for key and integer as value (that represent a quantity of occurrences)
   	 	Map<Id, integer> contactCount = new Map<Id, integer>();
        
        //We create a map that contains ID for key and integer as value (that represent a quantity of occurrences)
        //We iterate throught the list of offers and with the Buyer_c.id we complete the map's key. If ID is repeted we increased the value of this key
        For (Offer__c O: OfferList) {
            if (!contactCount.containsKey(O.Buyer__r.Id)) {
                contactCount.put(O.Buyer__r.Id,1);
            } else {
                
                Integer Count = contactCount.get(O.Buyer__r.Id)+1;
        		contactCount.put(O.Buyer__r.Id, Count);
            }
                 
		}
        
        //We evaluate if each Buyer (represent by the key of map) have the same or bigger number of contact
        
        //In this for we iterate throught the list of map's key and evaluate if the value is the same or bigger that integer 
        //If with the integer input as parameter is true(meet the condition)we add this contact to the list for return 
        for (Id value: contactCount.keySet()){
            if (contactCount.get(value) >= c){
				result.add(value);
            }
        }
        
        //we return the list of contacts
        return resultCont;
    }
    
/*c) Create a method called PropertiesbyAccount which receives an AccountId, and returns a list
of Properties that received offers by Contacts of that Account.*/


public static List<Property__c> propertiesByAccount(id acc){
        
        //Create a list of offers(and its properties) with contacts the that are related to the account ID (input as parameter) 
        //Create a list of properties for return
        //We create a set to iterate in the list of offers to avoid repeated porperties id
        
        List<Offer__c> offers = [SELECT id, Buyer__r.id, name, Property__r.id, Property__r.Name, Property__r.Price__c FROM Offer__c WHERE Buyer__r.AccountId = :acc];
        List<Property__c> ppty = new List<Property__c>();
        Set<id> setppty = new Set<id>();
        
        for(Offer__c o : offers){
            setppty.add(o.Property__r.id);
        }
        
        //We add the properties to the List to return 
        ppty = [SELECT Name, id, Price__c FROM Property__c WHERE id IN :setppty];
        
        
        //We return the list of properties 
        return ppty;
    }

}