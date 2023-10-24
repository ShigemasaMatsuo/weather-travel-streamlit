import requests
from datetime import datetime
from datetime import timedelta
import random
import streamlit as st
import pandas as pd

#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼

#===geojs API===========================================
def geojs_API():
    geo_request_url = "https://get.geojs.io/v1/ip/geo.json"
    geodata = requests.get(geo_request_url).json()
    latitude=geodata["latitude"]
    longitude=geodata["longitude"]
    return latitude, longitude

#===weatherAPI with latitude/longitude============
def weatherAPI_current():
    weather_request_url = "http://api.weatherapi.com/v1/current.json?key=ed44da5ef31149198b364255230410&q={}&aqi=no&lang={}".format(latitude +"," + longitude,langtype)
    weatherdata = requests.get(weather_request_url).json()
    #===weatherAPIから自分の現在地のcity/region/country/time/天気結果/気温結果/天気アイコンURLを取得==========
    city = weatherdata["location"]["name"]
    region = weatherdata["location"]["region"]
    country = weatherdata["location"]["country"]
    time = weatherdata["location"]["localtime"]
    tempresult = weatherdata["current"]["temp_c"]
    weathericon = "https:" + weatherdata["current"]["condition"]["icon"]
    return city, region, country, time, tempresult, weathericon

#===wikipedia main API===========================================
def wiki():
    wiki_request_url = "https://{}.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles={}".format(langtype, cityname)
    wikidata = requests.get(wiki_request_url).json()
    wikisummary=wikidata["query"]["pages"][str(pageid)]["extract"]
    return wikisummary


#===wikipedia API for latitude/longitude EN===========================================
def wikigeo():
    wikigeo_request_url = "https://en.wikipedia.org/w/api.php?format=json&action=query&formatversion=2&prop=coordinates&titles={}".format(cityname)
    wikigeodata = requests.get(wikigeo_request_url).json()
    wikigeolat=wikigeodata["query"]["pages"][0]["coordinates"][0]["lat"]
    wikigeolon=wikigeodata["query"]["pages"][0]["coordinates"][0]["lon"]
    return wikigeolat, wikigeolon

#===wikipedia API for latitude/longitude JP===========================================
def wikigeoJP():
    wikigeoJP_request_url = "https://en.wikipedia.org/w/api.php?format=json&action=query&formatversion=2&prop=coordinates&titles={}".format(cityname1)
    wikigeoJPdata = requests.get(wikigeoJP_request_url).json()
    wikigeoJPlat=wikigeoJPdata["query"]["pages"][0]["coordinates"][0]["lat"]
    wikigeoJPlon=wikigeoJPdata["query"]["pages"][0]["coordinates"][0]["lon"]
    return wikigeoJPlat, wikigeoJPlon


#===wikipedia Summary API===========================================
def wiki_id():
    wikiid_request_url = "https://{}.wikipedia.org/api/rest_v1/page/summary/{}".format(langtype, cityname)
    wikiiddata = requests.get(wikiid_request_url).json()
    pageid=wikiiddata["pageid"]
    wikiurl=wikiiddata["content_urls"]["desktop"]["page"]
    wikithumnail=wikiiddata["thumbnail"]["source"]
    wikidesc=wikiiddata["description"]
    return pageid, wikiurl, wikithumnail, wikidesc

#===weatherAPI for random City（ランダムCityの値を使用）===========================================
def weatherAPI_city():
    wheather_request_url2 = "http://api.weatherapi.com/v1/current.json?key=ed44da5ef31149198b364255230410&q={}&aqi=no&lang={}".format(cityname, langtype)
    wheatherdata2 = requests.get(wheather_request_url2).json()
    #===weatherAPIからランダムcityのtime/天気結果/気温結果/天気アイコンURLを取得==========
    tempresult2 = wheatherdata2["current"]["temp_c"]
    weathericon2 = "https:" + wheatherdata2["current"]["condition"]["icon"]
    time2 = wheatherdata2["location"]["localtime"]
    city2 = wheatherdata2["location"]["name"]
    country2 = wheatherdata2["location"]["country"]
    return  tempresult2, weathericon2, time2, city2, country2

#===Airport code definition===========================================
def aireport_code():
    if cityname == "Ankara" or cityname == "アンカラ":
        dest = "esb"
        return dest
    elif cityname == "Beijing" or cityname == "北京市":
        dest = "bjsa"
        return dest
    elif cityname == "Brasília" or cityname == "ブラジリア":
        dest = "bsb"
        return dest    
    elif cityname == "Windhoek"or cityname == "ウィントフック":
        dest = "wdha"
        return dest
    elif cityname == "Ulaanbaatar"or cityname == "ウランバートル":
        dest = "ubn"
        return dest    
    elif cityname == "Hanoi"or cityname == "ハノイ":
        dest = "han"
        return dest    
    elif cityname == "Pyongyang"or cityname == "平壌直轄市":
        dest = "fnj"
        return dest    
    elif cityname == "Cairo"or cityname == "カイロ":
        dest = "cai"
        return dest    
    elif cityname == "Ottawa"or cityname == "オタワ":
        dest = "yowa"
        return dest    
    elif cityname == "Lima":
        dest = "lim"
        return dest    
    elif cityname == "Khartoum"or cityname == "ハルツーム":
        dest = "krt"
        return dest    
    elif cityname == "Dar es Salaam"or cityname == "ダルエスサラーム":
        dest = "dar"
        return dest    
    elif cityname == "Yamoussoukro"or cityname == "ヤムスクロ":
        dest = "abj"
        return dest    
    elif cityname == "Dodoma"or cityname == "ドドマ":
        dest = "dod"
        return dest    
    elif cityname == "Moscow"or cityname == "モスクワ":
        dest = "mosc"
        return dest    
    elif cityname == "Baku"or cityname == "バクー":
        dest = "gyd"
        return dest    
    elif cityname == "Abidjan"or cityname == "アビジャン":
        dest = "abj"
        return dest    
    elif cityname == "Suva":
        dest = "suv"
        return dest    
    elif cityname == "Riyadh"or cityname == "リヤド":
        dest = "ruh"
        return dest    
    elif cityname == "Sucre"or cityname == "スクレ (ボリビア)":
        dest = "sre"
        return dest    
    elif cityname == "Amman"or cityname == "アンマン":
        dest = "amma"
        return dest    
    elif cityname == "Bogotá"or cityname == "ボゴタ":
        dest = "bog"
        return dest    
    elif cityname == "London"or cityname == "ロンドン":
        dest = "lond"
        return dest    
    elif cityname == "Bangkok"or cityname == "バンコク":
        dest = "bkkt"
        return dest    
    elif cityname == "Tripoli, Libya"or cityname == "トリポリ":
        dest = "mji"
        return dest    
    elif cityname == "Tegucigalpa"or cityname == "テグシガルパ":
        dest = "tgu"
        return dest    
    elif cityname == "Mexico City"or cityname == "メキシコシティ":
        dest = "mexa"
        return dest    
    elif cityname == "Rome"or cityname == "ローマ":
        dest = "rome"
        return dest    
    elif cityname == "Tehran"or cityname == "テヘラン":
        dest = "thra"
        return dest    
    elif cityname == "Nouakchott"or cityname == "ヌアクショット":
        dest = "nkc"
        return dest    
    elif cityname == "Abu Dhabi"or cityname == "アブダビ市":
        dest = "auh"
        return dest    
    elif cityname == "Harare"or cityname == "ハラレ":
        dest = "hre"
        return dest    
    elif cityname == "Cetinje"or cityname == "ツェティニェ":
        dest = "tgd"
        return dest    
    elif cityname == "Berlin"or cityname == "ベルリン":
        dest = "ber"
        return dest    
    elif cityname == "Kyiv"or cityname == "キーウ":
        dest = "kiev"
        return dest    
    elif cityname == "Canberra"or cityname == "キャンベラ":
        dest = "cbr"
        return dest    
    elif cityname == "Astana"or cityname == "アスタナ":
        dest = "nqz"
        return dest    
    elif cityname == "Aden"or cityname == "アデン":
        dest = "ade"
        return dest    
    elif cityname == "Kigali"or cityname == "キガリ":
        dest = "kgl"
        return dest    
    elif cityname == "Havana"or cityname == "ハバナ":
        dest = "hav"
        return dest    
    elif cityname == "Lilongwe"or cityname == "リロングウェ":
        dest = "llw"
        return dest    
    elif cityname == "Helsinki"or cityname == "ヘルシンキ":
        dest = "hel"
        return dest    
    elif cityname == "Abuja"or cityname == "アブジャ":
        dest = "abv"
        return dest    
    elif cityname == "Nairobi"or cityname == "ナイロビ":
        dest = "nboa"
        return dest    
    elif cityname == "Nuuk"or cityname == "ヌーク":
        dest = "goh"
        return dest    
    elif cityname == "Pretoria"or cityname == "プレトリア":
        dest = "pry"
        return dest    
    elif cityname == "Phnom Penh"or cityname == "プノンペン":
        dest = "pnh"
        return dest    
    elif cityname == "Baghdad"or cityname == "バグダード":
        dest = "bgw"
        return dest    
    elif cityname == "Jakarta"or cityname == "ジャカルタ":
        dest = "cgki"
        return dest    
    
#===cityname trans to EN===========================================
def cityname_trans():
    
    if cityname == "アンカラ":
        cityname1 = "Ankara"
        return cityname1
    elif cityname == "北京市":
        cityname1 = "Beijing"
        return cityname1
    elif cityname == "ブラジリア":
        cityname1 = "Brasília"
        return cityname1
    elif cityname == "ウィントフック":
        cityname1 = "Windhoek"
        return cityname1
    elif cityname == "ウランバートル":
        cityname1 = "Ulaanbaatar"
        return cityname1
    elif cityname == "ハノイ":
        cityname1 = "Hanoi"
        return cityname1
    elif cityname == "平壌直轄市":
        cityname1 = "Pyongyang"
        return cityname1
    elif cityname == "カイロ":
        cityname1 = "Cairo"
        return cityname1
    elif cityname == "オタワ":
        cityname1 = "Ottawa"
        return cityname1
    elif cityname == "ハルツーム":
        cityname1 = "Khartoum"
        return cityname1
    elif cityname == "ダルエスサラーム":
        cityname1 = "Dar es Salaam"
        return cityname1
    elif cityname == "ヤムスクロ":
        cityname1 = "Yamoussoukro"
        return cityname1
    elif cityname == "ドドマ":
        cityname1 = "Dodoma"
        return cityname1
    elif cityname == "モスクワ":
        cityname1 = "Moscow" 
        return cityname1
    elif cityname == "バクー":
        cityname1 = "Baku"
        return cityname1
    elif cityname == "アビジャン":
        cityname1 = "Abidjan"
        return cityname1
    elif cityname == "リヤド":
        cityname1 = "Riyadh"
        return cityname1
    elif cityname == "スクレ (ボリビア)":
        cityname1 = "Sucre"
        return cityname1
    elif cityname == "アンマン":
        cityname1 = "Amman"
        return cityname1
    elif cityname == "ボゴタ":
        cityname1 = "Bogotá"
        return cityname1
    elif cityname == "ロンドン":
        cityname1 = "London"
        return cityname1
    elif cityname == "バンコク":
        cityname1 = "Bangkok"
        return cityname1
    elif cityname == "トリポリ":
        cityname1 = "Tripoli, Libya"
        return cityname1
    elif cityname == "テグシガルパ":
        cityname1 = "Tegucigalpa"
        return cityname1
    elif cityname == "メキシコシティ":
        cityname1 = "Mexico City" 
        return cityname1
    elif cityname == "ローマ":
        cityname1 = "Rome"
        return cityname1
    elif cityname == "テヘラン":
        cityname1 = "Tehran"
        return cityname1
    elif cityname == "ヌアクショット":
        cityname1 = "Nouakchott"
        return cityname1
    elif cityname == "アブダビ市":
        cityname1 = "Abu Dhabi"
        return cityname1
    elif cityname == "ハラレ":
        cityname1 = "Harare"
        return cityname1
    elif cityname == "ツェティニェ":
        cityname1 = "Cetinje"
        return cityname1
    elif cityname == "ベルリン":
        cityname1 = "Berlin"
        return cityname1
    elif cityname == "キーウ":
        cityname1 = "Kyiv"
        return cityname1
    elif cityname == "キャンベラ":
        cityname1 = "Canberra"
        return cityname1
    elif cityname == "アスタナ":
        cityname1 = "Astana"
        return cityname1
    elif cityname == "アデン":
        cityname1 = "Aden"
        return cityname1
    elif cityname == "キガリ":
        cityname1 = "Kigali"
        return cityname1
    elif cityname == "ハバナ":
        cityname1 = "Havana"
        return cityname1
    elif cityname == "リロングウェ":
        cityname1 = "Lilongwe"
        return cityname1
    elif cityname == "ヘルシンキ":
        cityname1 = "Helsinki"
        return cityname1
    elif cityname == "アブジャ":
        cityname1 = "Abuja"  
        return cityname1
    elif cityname == "ナイロビ":
        cityname1 = "Nairobi"
        return cityname1
    elif cityname == "ヌーク":
        cityname1 = "Nuuk"
        return cityname1
    elif cityname == "プレトリア":
        cityname1 = "Pretoria"
        return cityname1
    elif cityname == "プノンペン":
        cityname1 = "Phnom Penh"
        return cityname1
    elif cityname == "バグダード":
        cityname1 = "Baghdad"
        return cityname1
    elif cityname == "ジャカルタ":
        cityname1 = "Jakarta"
        return cityname1
    
    

#▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

#===set button================================================
col1, col2, col3, col4 = st.columns([2,3.5,2,2.5])
with col1:
    langradio = st.radio("language",["EN","JP"], horizontal=True)
with col2:
    st.write("")
    button = st.button("Explore")

#===execute button=====================================
if button:
    if langradio == "EN":
        
        langtype="en"

        geojs_result = geojs_API()
        latitude = geojs_result[0]
        longitude = geojs_result[1]

        wetherEN_result = weatherAPI_current()
        city = wetherEN_result[0]
        region = wetherEN_result[1]
        country = wetherEN_result[2]
        time = wetherEN_result[3]
        tempresult = wetherEN_result[4]
        weathericon = wetherEN_result[5]

    #=========================
        with col3:
            st.write(time)
            st.image(weathericon, width=32)
        with col4:
            st.write(city + "/" + country)
            st.write(str(tempresult) + "℃")


        st.markdown("---")   


    #===random City array===========================================
        citylist=["Ankara","Beijing","Brasília","Windhoek","Ulaanbaatar","Hanoi","Pyongyang","Cairo","Ottawa", \
                "Lima","Khartoum","Dar es Salaam","Yamoussoukro","Dodoma","Moscow","Baku","Abidjan","Suva","Riyadh", \
                "Sucre","Amman","Bogotá","London","Bangkok","Tripoli, Libya","Tegucigalpa","Mexico City","Rome","Tehran", \
                "Nouakchott","Abu Dhabi","Harare","Cetinje","Berlin","Kyiv","Canberra","Astana","Aden","Kigali", \
                "Havana","Lilongwe","Helsinki","Abuja","Nairobi","Nuuk","Pretoria","Phnom Penh","Baghdad","Jakarta", \
                ]
        

        cityname=random.choice(citylist)



    #===generate SkyScanner URL===========================================
    #date: 7days&14days from today
        td = timedelta(days=7)
        day = datetime.now()
        date = day.date()
        oneweek = date + td
        twoweek =  date + td + td
    #Origin
        ori = "tyoa"
    #Destination
        dest = aireport_code()
    #SkyScanner URL
        skyscannerURL = "https://www.skyscanner.jp/transport/flights/{}/{}/{}/{}/?adults=1&adultsv2=1&cabinclass=economy&children=0&childrenv2=&inboundaltsenabled=false&infants=0&originentityid=27542089&outboundaltsenabled=false&preferdirects=false&ref=home&rtn=1&locale=en-US".format(ori,dest,oneweek,twoweek)

    #===API result=================================
        wiki_id_EN_result = wiki_id()
        pageid = wiki_id_EN_result[0]
        wikiurl = wiki_id_EN_result[1]
        wikithumnail = wiki_id_EN_result[2]

        wikisummary = wiki()
        
        weatherAPI_EN_city_result = weatherAPI_city()
        tempresult2 = weatherAPI_EN_city_result[0]
        weathericon2 = weatherAPI_EN_city_result[1]
        time2 = weatherAPI_EN_city_result[2]
        city2 = weatherAPI_EN_city_result[3]
        country2 = weatherAPI_EN_city_result[4]

        wikigeodata = wikigeo()
        wikigeolat = wikigeodata[0]
        wikigeolon= wikigeodata[1]

    #===generate googleMap URL===========================================
        googlecity = cityname.replace(" ", "")
        googlecountry = country2.replace(" ", "")
        googlemapurl="https://www.google.com/maps/search/?api=1&query={}".format(googlecity + "/" + googlecountry)
        
    #=========================
        col1, col2, col3 = st.columns([2,4.2,3.8])
        with col1:
            st.write(time2)
            st.image(weathericon2, width=60)
            st.write("📖[wikipedia]({})".format(wikiurl))
            st.write("🗺[Google Map]({})".format(googlemapurl))
        with col2:
            st.write(cityname + "/" + country2)
            st.write("")
            st.write(str(tempresult2) + "℃")
            st.write("")
            st.write("🛫[Skyscanner]({})".format(skyscannerURL))
        with col3:
            st.image(wikithumnail, width=250)

        st.text_area("wikipedia summary", wikisummary, height=300)
        data = pd.DataFrame({
            'latitude': [float(latitude), float(wikigeolat)],
            'longitude': [float(longitude), float(wikigeolon)]
            })
        st.map(data, zoom=1, size=200000)

        
    #◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇

    else:
        langtype="ja"

        geojs_result = geojs_API()
        latitude = geojs_result[0]
        longitude = geojs_result[1]

        wetherJP_result = weatherAPI_current()
        city = wetherJP_result[0]
        region = wetherJP_result[1]
        country = wetherJP_result[2]
        time = wetherJP_result[3]
        tempresult = wetherJP_result[4]
        weathericon = wetherJP_result[5]

    #=========================
        with col3:
            st.write(time)
            st.image(weathericon, width=40)
        with col4:
            st.write(city + "/" + country)
            st.write(str(tempresult) + "℃")
            
        st.markdown("---")   

    #===random City array===========================================
        citylist=["アンカラ","北京市","ブラジリア","ウィントフック","ウランバートル","ハノイ","平壌直轄市","カイロ","オタワ", \
                "ハルツーム","ダルエスサラーム","ヤムスクロ","ドドマ","モスクワ","バクー","アビジャン","リヤド", \
                "スクレ (ボリビア)","アンマン","ボゴタ","ロンドン","バンコク","トリポリ","テグシガルパ","メキシコシティ","ローマ","テヘラン", \
                "ヌアクショット","アブダビ市","ハラレ","ツェティニェ","ベルリン","キーウ","キャンベラ","アスタナ","アデン","キガリ", \
                "ハバナ","リロングウェ","ヘルシンキ","アブジャ","ナイロビ","ヌーク","プレトリア","プノンペン","バグダード","ジャカルタ", \
                ]

        cityname=random.choice(citylist)



    #===generate SkyScanner URL===========================================
    #date: 7days&14days from today
        td = timedelta(days=7)
        day = datetime.now()
        date = day.date()
        oneweek = date + td
        twoweek =  date + td + td
    
    #origin
        ori = "tyoa"
    #destination
        dest = aireport_code()

    #SkyScanner URL
        skyscannerURL = "https://www.skyscanner.jp/transport/flights/{}/{}/{}/{}/?adults=1&adultsv2=1&cabinclass=economy&children=0&childrenv2=&inboundaltsenabled=false&infants=0&originentityid=27542089&outboundaltsenabled=false&preferdirects=false&ref=home&rtn=1&locale=ja-JP".format(ori,dest,oneweek,twoweek)

    #====================================
        wiki_id_JP_result = wiki_id()
        pageid = wiki_id_JP_result[0]
        wikiurl = wiki_id_JP_result[1]
        wikithumnail = wiki_id_JP_result[2]
        wikidesc = wiki_id_JP_result[3]

        wikisummary = wiki()
        
        weatherAPI_JP_city_result = weatherAPI_city()
        tempresult2 = weatherAPI_JP_city_result[0]
        weathericon2 = weatherAPI_JP_city_result[1]
        time2 = weatherAPI_JP_city_result[2]
        city2 = weatherAPI_JP_city_result[3]
        country2 = weatherAPI_JP_city_result[4]

        cityname1 = cityname_trans()

        wikigeoJPdata = wikigeoJP()
        wikigeoJPlat = wikigeoJPdata[0]
        wikigeoJPlon= wikigeoJPdata[1]

    #===generate googleMap URL===========================================
        googlecity = cityname.replace(" ","")
        googlecountry = wikidesc.replace(" ","")
        if cityname == "ロンドン":
            googlecountry = "イギリス"
        elif cityname == "ドドマ":
            googlecountry = "タンザニア"
        elif cityname == "スクレ (ボリビア)":
            googlecountry = "ボリビア"

        googlemapurl="https://www.google.com/maps/search/?api=1&query={}".format(googlecity + "/" + googlecountry)
         

    #=========================
        col1, col2, col3 = st.columns([2,4.2,3.8])
        with col1:
            st.write(time2)
            st.image(weathericon2, width=60)
            st.write("📖[wikipedia]({})".format(wikiurl))
            st.write("🗺[Google Map]({})".format(googlemapurl))
        with col2:
            st.write(cityname + " (" + wikidesc + ")")
            st.write("")
            st.write(str(tempresult2) + "℃")
            st.write("")
            st.write("🛫[Skyscanner]({})".format(skyscannerURL))
        with col3:
            st.image(wikithumnail, width=250)

        st.text_area("wikipedia summary", wikisummary, height=250)

        data = pd.DataFrame({
            'latitude': [float(latitude), float(wikigeoJPlat)],
            'longitude': [float(longitude), float(wikigeoJPlon)]
            })
        st.map(data, zoom=1, size=200000)
        

