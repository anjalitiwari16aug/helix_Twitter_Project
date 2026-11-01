package tech.codingclub.helix.entity;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import tech.codingclub.helix.global.HttpURLConnectionExample;

import java.util.Date;

public class WikipediaDownloader {
    private String keyword;
    public WikipediaDownloader(){

    }
    public WikipediaDownloader(String keyword) {
        this.keyword = keyword;
    }


    public WikiResult getResult() {
        //get clean keyword
        //get the url for wikipedia
        //make a GET request to wikipedia!
        //Parsing the useful results using jsoup
        //showing results!
        if(this.keyword==null||this.keyword.length()==0){
            return null;
        }
        //step-1
        this.keyword = this.keyword.trim().replaceAll("[ ]+","_");

        //step-2
        String wikiUrl = getWikipediaUrlForQuery(this.keyword);
        String response = "";
        String imageUrl = null;
        try {
            //step-3
            String wikipediaResponseHTML = HttpURLConnectionExample.sendGet(wikiUrl);//ctrl+p
           // System.out.println(wikipediaResponseHTML);
            //step-4
            Document document = Jsoup.parse(wikipediaResponseHTML,"https://en.wikipedia.org");
            //Elements childElements = document.body().select(".mw-parser-output > *");
            Elements para = document.select("p");
            for (Element p: para){
                String paraText = p.text().trim();

                if(paraText.length()>10){
                    response = paraText;
                    break;
                }

//            int state = 0;//initially
//            for(Element childElement : childElements){
//                if(state==0){
//                    if(childElement.tagName().equals("table")){
//                        state=1;
//                    }
//                }else if(state==1) {
//                    if (childElement.tagName().equals("p")) {
//                        state = 2;
//                        response = childElement.text();
//                        break;
//                    }
//                }
            }
            Elements image = document.select(".infobox img");

            if (image != null) {
                String src = image.attr("abs:src");
                if (!src.isEmpty()) {
                    imageUrl = src;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }



        WikiResult wikiResult = new WikiResult(this.keyword,response,imageUrl);
        //PUSH result into database

        return  wikiResult;
    }

    private String getWikipediaUrlForQuery(String cleanKeyword) {
        return "https://en.wikipedia.org/wiki/"+cleanKeyword;
    }



}
