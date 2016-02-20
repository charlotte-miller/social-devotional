# Social Devotional

**Our mission** is to educate, encourage and equip the church with every effective technology.

  - **Educate:** 	Clarify the nature of God and creation
  - **Encourage:** 	Stir the faith of the young, tired, & dry believer
  - **Equip:**		Supply resources to stand against evil

**Our plan** is to spread the existing work of apostles, prophets, evangelists, pastors, and teachers as wise stewards of the technology gifted to our generation.

**Ephesians 4:11-15**
*Now these are the gifts Christ gave to the church: the apostles, the prophets, the evangelists, and the pastors and teachers.  Their responsibility is to equip God's people to do his work and build up the church, the body of Christ.  This will continue until we all come to such unity in our faith and knowledge of God's Son that we will be mature in the Lord, measuring up to the full and complete standard of Christ.*

*Then we will no longer be immature like children.  We won't we tossed and blown about by every wind of new teaching.  We will not be influenced when people try to trick us with lies so clever they sound like truth.  Instead we will speak truth in love, growing in every way more and more like Christ who is the head of his body, the church.*

## Technical Architecture
![Service Oriented Architectural Overview](https://bitbucket.org/chip_miller/social-devotional/raw/7ea5cb2092876e17801010e524288bb774002418/doc/soa_architecture.png)


## Pages

### Library
/library?q=keywords                                   #=>  <small>studies</small>#index
/library/:study-name                                  #=>  studies#show
/library/:study-name/lesson/:index-within-study       #=>  lesson#show

### Groups
/groups?q=keywords                                    #=> groups#index   (your dashboard or "find a group" (depending on if you have any))
/groups/:id                                           #=> groups#show
/groups/new                                           #=> groups#new
/groups/:group_id/

### Questions
/groups/:group_id/questions                           #=> questions#index
/groups/:group_id/questions/:id                       #=> questions#show  (include answers ?)
/groups/:group_id/questions/new                       #=> questions#new
/groups/:group_id/questions/new?verify=true           #=> questions#new

### Answers
/question/:id/answers/                                #=> answers#index
/question/:id/answers/ (POST)                         #=> answers#create
/answers/:id/block
/answers/:id/star

### Comments
/groups/:group_id/comments?q=keywords                 #=> comments/index
/groups/:group_id/comments/:id                        #=> comments/show



## Contributing
So my dear brothers and sisters, be strong and immovable. Always work enthusiastically for the Lord, for the you that nothing you do for the Lord is ever useless.  1 Corinthians 15:58


## Roadmap
* MVP
* * Podcast Integration
* * Browse and watch audio/video messages
* * Comments and Q&A
* * Groups
* * User accounts w/ soft-delte
* * Moderation
* * * Comments
* * * Q&A
* * * Block / Soft-delete user

* Develop group leaders
* * Allow the leader to moderate 'blocks'
* * Provide a dashboard w/ charts and stats on their activity
* * Automatically nominate active members

* Recommendation Engine


## License

Social Devotional is released under the [MIT License](http://www.opensource.org/licenses/MIT).