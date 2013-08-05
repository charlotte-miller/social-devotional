# Social Devotional
Now these are the gifts Christ gave to the church: the apostles, the prophets, the evangelists, and the pastors and teachers.  **Their responsibility is to equip God's people** to do his work and build up the church, the body of Christ.  This will continue until we all come to such unity in our faith and knowledge of God's Son that we will be mature in the Lord, measuring up to the full and complete standard of Christ.

Then we will no longer be immature like children.  We won't we tossed and blown about by every wind of new teaching.  We will not be influenced when people try to trick us with lies so clever they sound like truth.  Instead we will **speak truth in love**, growing in every way more and more like Christ who is the head of his body, the church.  Ephesians 4:11-15  

![Service Oriented Architectural Overview](https://bitbucket.org/chip_miller/social-devotional/raw/7ea5cb2092876e17801010e524288bb774002418/doc/soa_architecture.png)

## Integrated Resources
* **Mars Hill**: http://marshill.org/teaching/podcast-info/
* **Mars Hill**: http://feeds.marshill.com/marshill/mark-driscoll/video  (http://marshill.com/feeds)
* **The Village Church [Sermons]**: http://feeds.feedburner.com/TVCSermonAudio
* **The Village Church [Other]**: http://www.thevillagechurch.net/resources/feeds-podcasts/
* **Cornerstone Church**: http://cornerstone-sf.org/rss/tv/

_Possible Resource_: 
* [Sermon Cloud](http://www.sermoncloud.com/)
* [Redeemer (CA)](http://visitredeemer.org/): http://visitredeemer.org/sermons/?podcast
* [Tim Keller](https://itunes.apple.com/us/podcast/timothy-keller-podcast/id352660924)


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

* Develop group leaders
* * Allow the leader to moderate 'blocks' 
* * Provide a dashboard w/ charts and stats on their activity
* * Automatically nominate active members

* Recommendation Engine


## TODO
* lesson and meeting to_params using position - verify routes and update controllers
* scaffold answers
* questions_controller before_filter assign url params
* questions_controller before_filter assign author and source
* questions/show shallow routes (for answers as well)

## Security
* Capistrano replace:
* * database.yml
* * secret_token.rb
