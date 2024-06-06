/**
 * @class AutoCreateCodeTest
 * @description AutoCreateCodeクラスのテストクラス
 */
@isTest
private class AutoCreateCodeTest {

    /**
     * @description テストデータをセットアップするメソッド
     */
    @testSetup
    static void setupTestData() {
        // テスト用のアカウントを作成
        Account testAccount = new Account(Name = 'Test Account333');
        insert testAccount;

        // テスト用の商談を作成
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 1000
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = testAccount.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 2000
        );
        insert new List<Opportunity>{ opp1, opp2 };
    }

    /**
     * @description バッチ処理の実行をテストするメソッド
     */
    @isTest
    static void testBatchExecution() {
        // バッチインスタンスを作成
        AutoCreateCode batch = new AutoCreateCode();

        // バッチを実行
        Test.startTest();
        Database.executeBatch(batch);
        Test.stopTest();

        // 結果を検証
        // Account testAccount = [SELECT Id, Total_Opportunity_Amount__c FROM Account LIMIT 1];
        // System.assert(3000 == testAccount.Total_Opportunity_Amount__c, '合計金額が正しく計算されていません');
    }
}
