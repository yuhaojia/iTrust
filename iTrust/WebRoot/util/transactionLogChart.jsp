<%@page import="edu.ncsu.csc.itrust.enums.TransactionType"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="java.util.List"%>
<%@page import="edu.ncsu.csc.itrust.beans.TransactionBean"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="edu.ncsu.csc.itrust.NumLoggedInMID" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="edu.ncsu.csc.itrust.NumSecondaryMID" %>
<%@ page import="edu.ncsu.csc.itrust.NumTransactionType" %>

<html>
<head>
    <title>Transaction Filter and chart</title>
    <style>
        body, td{
            font-family: sans-serif;
            font-size: 8pt;
        }
    </style>
</head>
<body>
<h1>Test Utilities</h1>
A few clarifications:
<ul>
    <li>The <b>Type</b> is the name of the Java enum (from <code>edu.ncsu.csc.itrust.enums.TransactionType</code>)</li>
    <li>The <b>Code</b> is the actual key that gets stored in the database, defined in the Transaction Type enum. Here's the <a href="#transactioncodes">table of transaction codes</a></a></li>
    <li>The <b>Description</b> is plain-English description of that logging type
</ul>

<%



    List<TransactionBean> list = DAOFactory.getProductionInstance().getTransactionDAO().getAllTransactions();
    List<NumLoggedInMID> numLoggedInMIDs = new ArrayList<NumLoggedInMID>();
    List<NumSecondaryMID> numSecondaryMIDs = new ArrayList<NumSecondaryMID>();
    List<NumTransactionType> numTransactionTypes = new ArrayList<NumTransactionType>();


    for (TransactionBean t : list) {
        NumLoggedInMID a = new NumLoggedInMID(t.getLoggedInMID());
        NumSecondaryMID b = new NumSecondaryMID(t.getSecondaryMID());
        NumTransactionType d = new NumTransactionType(t.getTransactionType());

        if ((numLoggedInMIDs.size() == 0)&&(numSecondaryMIDs.size()==0)&&(numTransactionTypes.size()==0)){
            numLoggedInMIDs.add(a);
            numSecondaryMIDs.add(b);
            numTransactionTypes.add(d);
        }
        else if ((numLoggedInMIDs.size() > 0)&&(numSecondaryMIDs.size()>0)&&(numTransactionTypes.size()>0)){
            boolean flag1 = false;
            boolean flag2 = false;
            boolean flag4 = false;

            for(NumLoggedInMID aa : numLoggedInMIDs){
                if(t.getLoggedInMID()==aa.getLoggedInMIDGot()){
                    aa.setNum(aa.getNum()+1);
                    flag1=true;
                }
            }

            if(flag1==true){
                numLoggedInMIDs.add(a);
            }

            for(NumSecondaryMID bb : numSecondaryMIDs){
                if(b.getSecondaryMIDGot()==bb.getSecondaryMIDGot()){
                    bb.setNum(bb.getNum()+1);
                    flag2=true;
                }
            }

            if(flag2==true){
                numSecondaryMIDs.add(b);
            }

            for(NumTransactionType dd : numTransactionTypes){
                if(d.getTransactionTypeGot()==dd.getTransactionTypeGot()){
                    dd.setNum(dd.getNum()+1);
                }
            }
            if(flag4==true){
                numTransactionTypes.add(d);
            }

        }
        else{
            //ERROR
        }

    }


    /*long [] loggedInMIDsGot = new long[0];
    int [] numloggedInMIDs = new int[0];
    int loggedInMIDnum = 0;
    long [] secondaryMIDsGot = new long[0];
    int [] numsecondaryMIDs = new int[0];
    int secondaryMIDnum = 0;*/
    //int num = 0;
    //int num = 0;


%>
<tr>
    <td><%= %><td>
    <td>/////////////////////////////////<td>
    <td><%= %><td>

<tr>

        <%
        //for (TransactionBean t : list) {

    %>


        <%
        //}
    %>

    <h1><a href="/iTrust">Back to iTrust</a></h1>
</body>
</html>
