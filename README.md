# Social Devotional (inactive)
[Wireframes](https://github.com/chip-miller/social-devotional/blob/master/doc/Social_Devotional%20Wireframes.pdf)
 | [Features](http://chip-miller.github.io/social-devotional/) | [Pivotal Tracker Export](https://github.com/chip-miller/social-devotional/blob/master/doc/pivotal_tracker.csv) | [Project Files](https://github.com/chip-miller/social-devotional/tree/master/doc/Product/Project)

[![Wireframe Sample](https://raw.githubusercontent.com/chip-miller/social-devotional/master/doc/Product/Features/assets/wireframes/wireframe_sample.png)](https://github.com/chip-miller/social-devotional/blob/master/doc/Social_Devotional%20Wireframes.pdf)

## Mission
We live in an amazing age for the Church. The Information Age is producing a massive online library of biblical resources, a long-tail of content covering every section of scripture. The modern Christian can swipe & click to high-quality biblical teaching daily, but few acquire the habit of daily Bible study. I believe an app can change that. **The Social Devotional project uses church podcasts as a curriculum, and utilizes social engagement to draw users deeper into a long- tail of content.**


## Pages

#### Library
```
/library?q=keywords                                   #=>  studies#index
/library/:study-name                                  #=>  studies#show
/library/:study-name/lesson/:index-within-study       #=>  lesson#show
```

#### Groups
```
/groups?q=keywords                                    #=> groups#index   (your dashboard or "find a group" (depending on if you have any))
/groups/:id                                           #=> groups#show
/groups/new                                           #=> groups#new
/groups/:group_id/
```

#### Questions
```
/groups/:group_id/questions                           #=> questions#index
/groups/:group_id/questions/:id                       #=> questions#show  (include answers ?)
/groups/:group_id/questions/new                       #=> questions#new
/groups/:group_id/questions/new?verify=true           #=> questions#new
```

#### Answers
```
/question/:id/answers/                                #=> answers#index
/question/:id/answers/ (POST)                         #=> answers#create
/answers/:id/block
/answers/:id/star
```

#### Comments
```
/groups/:group_id/comments?q=keywords                 #=> comments/index
/groups/:group_id/comments/:id                        #=> comments/show
```

## Roadmap
[Features](http://chip-miller.github.io/social-devotional/) | [Pivotal Tracker Export](https://github.com/chip-miller/social-devotional/blob/master/doc/pivotal_tracker.csv) | [Project Files](https://github.com/chip-miller/social-devotional/tree/master/doc/Product/Project)

## Contributing
Social Devotional is seeking a new maintainer. 
> So my dear brothers and sisters, be strong and immovable. Always work enthusiastically for the Lord, for you know that nothing you do for the Lord is ever useless.  _- 1 Corinthians 15:58_

## License
Social Devotional is released under the [MIT License](http://www.opensource.org/licenses/MIT).
