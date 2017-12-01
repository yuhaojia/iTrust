package edu.ncsu.csc.itrust;

import java.sql.Timestamp;

public class NumLoggedInMID {

    private long loggedInMIDGot;
    private int num;

    public NumLoggedInMID(long loggedInMIDGoti) {
        loggedInMIDGot = loggedInMIDGoti;
        num = 1;
    }

    public long getLoggedInMIDGot() {
        return loggedInMIDGot;
    }

    public int getNum() {
        return num;
    }

    public void setLoggedInMIDGot(long loggedInMIDGoti) {
        loggedInMIDGot = loggedInMIDGoti;
    }

    public void setNum(int num) {
        this.num = num;
    }


}
