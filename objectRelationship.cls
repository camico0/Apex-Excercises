/*Object Relationships
Create a Class with methods to practice object relationships. 

a) Write a method ContactCount that receives an account ID, and returns an Integer how many 
Contacts does that account has. (HINT: use .size() for the returned list) */

 public static integer ContactCount(id accID){
        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId = :accID];
        return conList.size();
    }
    
/*b) Write a method CaseCount that receives an account ID, and returns an Integer, how many 
Cases are related to that account or the related contacts. (HINT: Case have the AccountId and 
ContactId Fields, can you make sure you are not counting a Case twice, if it related to the contact and 
account at the same time?)*/



public static integer CaseCount(id accID){
        
        //Cases related with Account
        List<Case> caseList = [SELECT Id, ContactId FROM Case WHERE AccountId = :accID];
         
        //Contact related with Account
        List<Contact> ContList = [SELECT id FROM Contact WHERE AccountId = :accID];
        // List<ID> InnerJoin = [SELECT Contact.id FROM Contact WHERE Contact.AccountId = :accID AND (SELECT Case.id FROM Case WHERE Case.ContactId = Contact.id)];
        
        //List to save contacts Id's
        List<ID> contListId = New List<ID>();  
        
        //We get the IDs from the Contact List 
        for(contact con:ContList){
       	contListId.add(con.id);
        
        }	
       	
        //Get Cases with related contact using ContListId 
        List<Case> caseRelatedContact = [SELECT Id, ContactId FROM Case WHERE ContactId in :ContListId];
        
        
        //Create a Set to save the unique cases ID to avoid duplicate ID 
        Set<ID> myCasesIdSet = new Set<ID>();
		
        
        //We add the first list of ID Cases to the Set 
        for (Case c:caseRelatedContact) {
  			myCasesIdSet.add(c.Id);
    	
    	}
        
        //We add the Second list of ID Cases to the SET
        for (Case c:caseList) {
  			myCasesIdSet.add(c.Id);
    	
    	}
       	
        //We return the size of The Set that contains the unique ID Cases 
       	return myCasesIdSet.size();
       
 }
    


/*c) Write a method OpenCases that receives an account ID and return a list of the Open cases 
related to it, or to its contacts.*/


 public static list<Case> OpenCases(id accID){
        
	    List<Case> ListOpenCases = new list<Case>();
		ListOpenCases = [SELECT id FROM CASE 
                         WHERE ContactId IN (SELECT Id FROM Contact) AND AccountId = :accID AND Status = 'Open'];
        return ListOpenCases;
    }
    
}



/*d) Create a method AccountsWithOpenCases that returns a map with the Ids of the account 
and a list of the related Cases. (this time directly to the account and not to the contact)*/



public static map<id, List<Case>> AccountsWithOpenCases (id accID) {

        map <id, List<Case>> relatedOpenCases = new map<id, List<Case>>();
        List<Case> relatedCases = [SELECT id FROM Case WHERE AccountId = :accID AND Status = 'Open' ];
        relatedOpenCases.put(accID, relatedCases);

        return relatedOpenCases;

    }