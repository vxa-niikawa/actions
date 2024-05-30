/**
 * @class AutoCreateCodeTest
 * @description AutoCreateCodeクラスのバッチ処理をテストするためのテストクラスです。
 */
@isTest
public class AutoCreateCodeTest {

    /**
     * @description AutoCreateCodeバッチの実行をテストします。
     */
    @isTest
    public static void testBatchExecution() {
        // テストデータの作成
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity testOpportunity1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount.Id,
            CloseDate = Date.today(),
            StageName = 'Prospecting',
            Amount = 1000
        );
        Opportunity testOpportunity2 = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = testAccount.Id,
            CloseDate = Date.today(),
            StageName = 'Prospecting',
            Amount = 2000
        );
        insert new List<Opportunity>{testOpportunity1, testOpportunity2};

        // バッチの実行
        Test.startTest();
        AutoCreateCode batch = new AutoCreateCode();
        Database.executeBatch(batch);
        Test.stopTest();

        // 結果の検証
        testAccount = [SELECT Id, (SELECT Amount FROM Opportunities) FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(2, testAccount.Opportunities.size(), '商談の数が正しくありません');
        Decimal totalAmount = 0;
        for (Opportunity opp : testAccount.Opportunities) {
            totalAmount += opp.Amount;
        }
        System.assertEquals(3000, totalAmount, '合計金額が正しくありません');
    }
}