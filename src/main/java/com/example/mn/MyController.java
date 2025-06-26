package com.example.mn;


import java.util.HashSet;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyController {
	
	
	@RequestMapping("/")
	public String display(Model m)
	{
		
		HashSet<String> gamelist = new HashSet<>();

		try {
		    String url = "https://sattamatkaresult.net/";
		    Document doc = Jsoup.connect(url)
		            .userAgent("Mozilla/5.0")
		            .timeout(10000)
		            .get();

		    // ✅ Extract ALL matching <span id="game_name_list">
		    Elements gameSpans = doc.select("span#game_name_list");

		    for (Element gameSpan : gameSpans) {
		        String gameTitle = gameSpan.text().trim();
		        if (!gameTitle.isEmpty()) {
		            gamelist.add(gameTitle);
		        }
		    }   

		} catch (Exception e) {
		    e.printStackTrace();
		}

		// ✅ Send both to view
		m.addAttribute("gamelist", gamelist);
		
		return "redirect:https://main";
	}
	
	@RequestMapping("/chart/{game}")
	public String get(@PathVariable("game") String game,Model m)
	{
		

		// Step 1: Remove unwanted symbols
		String cleaned = game.replaceAll("[^a-zA-Z0-9 ]", "").trim();

		// Step 2: Replace spaces with hyphens
		String finalString = cleaned.replaceAll("\\s+", "-");

		
		String gamename = finalString.toLowerCase().concat("-panel-chart");
		System.out.println(gamename);
		String tableHtml = null;
		try {
		    String url = "https://sattamatkaresult.net/"+gamename;
		    Document doc = Jsoup.connect(url)
		            .userAgent("Mozilla/5.0")
		            .timeout(10000)
		            .get();

		    Element table = doc.select("table").first();

		    if (table != null) {
		        table.addClass("scraped-table");

		        Elements thElements = table.select("th");
		        String previousValue = null;

		        for (Element th : thElements) {
		            String currentValue = th.text().trim();

		            if (previousValue != null && previousValue.matches("\\d+")) {
		                try {
		                    int fn = Integer.parseInt(previousValue) % 10;
		                    int sn =Integer.parseInt(previousValue) / 10;
		                    
		                    int formsum = Integer.parseInt(previousValue) + 42;

		                    boolean marked = false;

		                    while (formsum != 0) {
		                        int rem = formsum % 10;

		                        if (rem < 5) {
		                            if (rem == fn || rem + 5 == fn) {
		                                th.attr("style", "background-color: green; color: white;");
		                                th.append("<br><span style='font-size:10px;'>&#10003;</span>");
		                                marked = true;
		                                break;
		                            }
		                        } else {
		                            if (rem == fn || rem - 5 == fn) {
		                                th.attr("style", "background-color: green; color: white;");
		                                th.append("<br><span style='font-size:10px;'>&#10003;</span>");
		                                marked = true;
		                                break;
		                            }
		                        }
		                        formsum /= 10;
		                    }

		                    // Add X mark if not matched
		                    if (!marked) {
		                        th.attr("style", "background-color: red; color: white;");
		                        th.append("<br><span style='font-size:10px;'> X</span>");
		                    }
		                    
		                    int i=0;
		            		while(i<2)
		            		{
		            			int rem = formsum%10;
		            			System.out.println(rem);
		            			
		            			if(rem<5)
		            			{
		            				if(rem==sn | rem+5==sn)
		            				{
		            					th.attr("style", "background-color: green; color: white;");
		                                th.append("<br><span style='font-size:10px;'>&#10003;</span>");
		                                marked = true;
		                                break;
		            				
		            				}
		            			}
		            			else
		            			{
		            				if(rem==sn | rem-5==sn)
		            				{
		            					th.attr("style", "background-color: green; color: white;");
		                                th.append("<br><span style='font-size:10px;'>&#10003;</span>");
		                                marked = true;
		                                break;
		            				}
		            			}		
		            			formsum=formsum/10;		
		            			i++;
		            		}
		            		 // Add X mark if not matched
		                    if (!marked) {
		                        th.attr("style", "background-color: red; color: white;");
		                        th.append("<br><span style='font-size:10px;'> X</span>");
		                    }

		                } catch (NumberFormatException e) {
		                    continue;
		                }
		            }

		            previousValue = currentValue;
		        }

		        tableHtml = table.outerHtml(); // ✅ table is now modified with styles
		    }

		} catch (Exception e) {
		    e.printStackTrace();
		}

		m.addAttribute("tableHtml", tableHtml);
		
		return "redirect:https://index";
	}

}
