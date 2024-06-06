/**
 * @class AutoCreateCode
 * @description このクラスは、今日の商談の合計金額を各アカウントに更新するバッチ処理を実行します。
 * @implements Database.Batchable<SObject>
 * @implements Database.Stateful
 */
public class AutoCreateCode implements Database.Batchable<SObject>, Database.Stateful {

    // バッチ間で共有するための変数
    private Map<Id, Decimal> accountTotals = new Map<Id, Decimal>();

    /**
     * @description バッチ処理の開始時に呼び出され、処理対象のレコードをクエリします。
     * @param BC Database.BatchableContext
     * @return Database.QueryLocator
     */
    public Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator([
            SELECT Id, Name, AccountId, Amount 
            FROM Opportunity 
            WHERE CloseDate = :Date.today()
            ORDER BY AccountId Asc
            Limit 1000
        ]);
    }

    /**
     * @description バッチ処理の各実行時に呼び出され、商談の合計金額を計算してアカウントに更新します。
     * @param BC Database.BatchableContext
     * @param scope List<Opportunity>
     */
    public void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        for (Opportunity opp : scope) {
            if (accountTotals.containsKey(opp.AccountId)) {
                accountTotals.put(opp.AccountId, accountTotals.get(opp.AccountId) + opp.Amount);
            } else {
                accountTotals.put(opp.AccountId, opp.Amount);
            }
        }
    }

    /**
     * @description バッチ処理の完了時に呼び出され、後処理を行います。
     * @param BC Database.BatchableContext
     */
    public void finish(Database.BatchableContext BC) {

        //for (Id accountId : accountTotals.keySet()) {
            // Account acc = [SELECT Id, Total_Opportunity_Amount__c FROM Account WHERE Id = :accountId LIMIT 1];
            // acc.Total_Opportunity_Amount__c = accountTotals.get(accountId);
            // update acc;
        //}
    }
}
