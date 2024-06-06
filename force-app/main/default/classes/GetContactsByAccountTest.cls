/**
 * @description       : 
 * @author            : t-niikawa
 * @group             : 
 * @last modified on  : 2024-06-06
 * @last modified by  : t-niikawa
**/
@isTest
private class GetContactsByAccountTest {
    @testSetup
    static void setupTestData() {
        // テスト用のアカウントを作成
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // テスト用の連絡先を作成
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@example.com',
            Phone = '1234567890',
            AccountId = testAccount.Id
        );
        insert testContact;
    }

    @isTest
    static void testGetContactsByAccount() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@example.com',
            Phone = '1234567890',
            AccountId = testAccount.Id
        );
        insert testContact;

        Test.startTest();
        List<Contact> contacts = GetContactsByAccount.getContacts(new List<Id>{testAccount.Id});
        Test.stopTest();

        System.assertEquals(1, contacts.size(), '取得した連絡先の数が正しくありません');
        // System.assertEquals('Test', contacts[0].FirstName, '取得した連絡先の名前が正しくありませません');
        // System.assertEquals('Contact', contacts[0].LastName, '取得した連絡先の姓が正しくありません');
        // System.assertEquals('test@example.com', contacts[0].Email, '取得した連絡先のメールアドレスが正しくありません');
        // System.assertEquals('1234567890', contacts[0].Phone, '取得した連絡先の電話番号が正しくありませません');
    }
}