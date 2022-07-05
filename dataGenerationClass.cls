/*Write a DATA GENERATION CLASS

Create a class with methods that generates data to be used during testing.
a) Write a Method, CreateAccount, that receive a Boolean and a String as parameters. 
The name will be the name of the account, the Boolean if true will insert the account if false 
will not. The method return the account created. */

public class DataGeneration {
    
    //METHOD FOR CREATING AN ACCOUNT 
    public static Account CreateAccount(Boolean b, String name){
        Account Acc = New Account(Name = name);
        	if (b == True) {
            	insert Acc;
            }
        System.debug(Acc);
         return Acc;
        
    }


/*b) Write a Method, CreateContact, receives a Boolean, a String and an Account ID. The string 
is the Last Name, the Boolean if true will insert the record, the account ID is the parent account. The 
method return a Contact.*/

    //METHOD FOR CREATING A CONTACT
    public static Contact CreateContact(Boolean b, String LName, ID AccId){
        Contact C = New Contact(LastName = LName, 
                                AccountId = AccId);
 		if(b == True){
            insert C;
        }
       
        return C;
    }


/*c) Write a Method, AccountBulk, receives a Boolean and 2 Integers, the Boolean if true the 
records will be inserted, the first number is how many Accounts will be created, the second Integer is 
how many contacts each of those accounts should have. The methods return a list of the Accounts 
created.*/


public static List<Account> AccountBulk (Boolean b, Integer NumAcc, Integer NumCont){
        
        
       List<Account> Accounts = New List<Account>();
       List<Contact> Contacts = New List<Contact>();
        
      		 For(Integer i = 0; i < NumAcc; i ++) {
                Account Acc = CreateAccount( False, 'ABC' + i);
                Accounts.add(Acc);

                 	
             }
        		if (b == True){
            	insert Accounts;
                    
             }
        		for (Account Acc : Accounts){
                    for (Integer j = 0; j < NumCont; j ++){
                  Contact Con = CreateContact(False, 'Lolo' + j, Acc.Id);
                  Contacts.add(Con);      
                }
                    
                }
                insert Contacts;
        		return Accounts;
  
    }
}


//d) Write a test class for this class with 100% code coverage.

@IsTest
private class DataGenerationTest {
    @IsTest

    private static void CreateAccountTest(){
        test.startTest();
        Account Juanita = DataGeneration.CreateAccount(True, 'Juanita');
        test.stopTest();
        system.assert(Juanita.Name == 'Juanita');
    }

    @IsTest

    private static void CreateContactTest(){
        test.startTest();
        Contact Pochoclo = DataGeneration.CreateContact(True, 'Pochoclo', '0018c00002HuQ0OAAV');
        test.stopTest();
        system.assert(Pochoclo.LastName == 'Pochoclo' && Pochoclo.AccountId == '0018c00002HuQ0OAAV');
    }

    @IsTest

    private static void AccountBulkTest(){
        test.startTest();
        List<Account> AccList = DataGeneration.AccountBulk(True, 4, 2);
        test.stopTest();
        system.assert(AccList.size() == 4);
        List<Contact> ConList = [SELECT id FROM Contact];
        system.assert(ConList.size() == 8);

    }

}
    