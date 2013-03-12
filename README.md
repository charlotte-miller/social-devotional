# Social Devotional
Now these are the gifts Christ gave to the church: the apostles, the prophets, the evangelists, and the pastors and teachers.  **Their responsibility is to equip God's people** to do his work and build up the church, the body of Christ.  This will continue until we all come to such unity in our faith and knowledge of God's Son that we will be mature in the Lord, measuring up to the full and complete standard of Christ.

Then we will no longer be immature like children.  We won't we tossed and blown about by every wind of new teaching.  We will not be influenced when people try to trick us with lies so clever they sound like truth.  Instead we will **speak truth in love**, growing in every way more and more like Christ who is the head of his body, the church.  Ephesians 4:11-15  

## Integrated Resources
* **Mars Hill**: http://marshill.org/teaching/podcast-info/
* **The Village Church [Sermons]**: http://feeds.feedburner.com/TVCSermonAudio
* **The Village Church [Other]**: http://www.thevillagechurch.net/resources/feeds-podcasts/

_Possible Resource_: 
* [Sermon Cloud](http://www.sermoncloud.com/)
* [Redeemer (CA)](http://visitredeemer.org/): http://visitredeemer.org/sermons/?podcast
* [Tim Keller](https://itunes.apple.com/us/podcast/timothy-keller-podcast/id352660924)


## Pages

### Library
/library?q=keywords                                   #=>  series#index  
/library/:series-name                                 #=>  series#show  
/library/:series-name/lesson/:index-within-series     #=>  lesson#show  

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




## Third Party Docs
* [acts_as_list](https://github.com/swanandp/acts_as_list)


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

* Recommendation Engine

* Develop group leaders
* * Automatically nominate active members

## TODO
* scaffold answers
* questions_controller before_filter assign url params
* questions_controller before_filter assign author and source
* rm admin::questions (not used).  Use block requests instead
* questions/show shallow routes (for answers as well)