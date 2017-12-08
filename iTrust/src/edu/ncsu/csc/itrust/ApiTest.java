package edu.ncsu.csc.itrust;

import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;

public class ApiTest {

    private static final String USER_AGENT = "Mozilla/5.0";

    public static String sendGET(String ICD9) throws IOException {
        String ICD10 = "";
        URL obj = new URL("http://www.lpitools.com/api/demo/icd9to10/" + ICD9);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", USER_AGENT);
        int responseCode = con.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) { // success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                if(inputLine.contains("\"Code\":")) {
                    String[] split = inputLine.split(":");
                    String test = split[1];
                    test = test.replace(".", "");
                    test = test.replace("\"", "");
                    test = test.replace(",", "");
                    in.close();
                    return test;
                }
                response.append(inputLine);
            }
            in.close();
            // print result
            System.out.println(response.toString());
        } else {
            System.out.println("GET request not worked");
        }
        return "Error";
    }


}
