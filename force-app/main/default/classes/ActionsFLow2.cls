/**
 * @description       : 
 * @author            : t-niikawa
 * @group             : 
 * @last modified on  : 2024-06-06
 * @last modified by  : t-niikawa
**/
public with sharing class ActionsFLow2 {
    
    @InvocableMethod(label='Get Contacts by Account ID' description='Returns the contacts related to a given Account ID')
    public static List<Contact> getContacts(List<Id> accountIds) {
        // Ensure only one Account ID is passed
        if (accountIds == null || accountIds.size() != 1) {
            throw new IllegalArgumentException('Exactly one Account ID must be provided auto release test 1');
        }

        Id accountId = accountIds[0];

        // Query to get the contacts related to the given Account ID
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountId = :accountId];

        return contacts;
    }
}
