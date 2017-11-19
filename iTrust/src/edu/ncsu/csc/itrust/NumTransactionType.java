package edu.ncsu.csc.itrust;

import edu.ncsu.csc.itrust.enums.TransactionType;

public class NumTransactionType {
    private TransactionType transactionTypeGot;
    private int num;

    public NumTransactionType(TransactionType transactionTypeGot) {
        this.transactionTypeGot = transactionTypeGot;
    }

    public TransactionType getTransactionTypeGot() {
        return transactionTypeGot;
    }

    public void setTransactionTypeGot(TransactionType transactionTypeGot) {
        this.transactionTypeGot = transactionTypeGot;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
