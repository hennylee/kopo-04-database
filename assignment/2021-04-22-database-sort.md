##  Oracle 9i와 Oracle 10g 정렬

## Distinct

- 9i : Sort(unique) 알고리즘 방식
- 10g : Hash(unique) 알고리즘 방식, 단 Order by 절을 시행할 경우 Sort(unique)



## Group by

- 9i : Sort group by

- 10g : Hash group by, 정렬 유무에 따라 Hash group by 사용


## 이진 정렬

## Hash 정렬

- 이진검색 오름차순으로 정렬된 리스트에서 특정한값으니 위치를 찾는 알고리즘

- hash함수를 이용해서 고저오딘 길이를 암호화된 ....

- Hash based Group by 

– 충분한 Memory일 경우 (즉 In-Memory Sort)일 경우 효과적
– Sort operation이 기존 방식에 비해 최대 5~10%까지 빠를 수 있다.

– 높은 cardinality (Row들의 Distinct가 많은 경우)일 경우 특히 효과적 (HASH방식 이므로)
– Faster CPU일 경우 더욱 효과적
– 적은 Column을 Select 했을 경우 특히 효과적 (Hash는 Memory부족에 의해 Disk로 내려가면 꽝)

- “GROUP BY”를 사용한 App가 “ORDER BY”를 기술하지 않더라도 Ordering된 결과를 Display하던
App들이 10g R2로 오면서 이 기능이 깨지게 되었음.
즉 반드시 Ordering이 필요하면 “GROUP BY”와 함께 “ORDER BY”를 기술해야 함.
(참고. 이는 Oracle의 Bug은 아니며 App의 잘못임)

## Oracle 10g
- 그리드 컴퓨팅
- 병렬 처리
- 대용량 데이터 처리


https://m.blog.naver.com/PostView.nhn?blogId=thurunet5&logNo=220155900914&proxyReferer=https:%2F%2Fwww.google.com%2F
