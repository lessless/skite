# for more details see: http://emberjs.com/guides/controllers/

Skite.AchievementsController = Ember.ArrayController.extend
  sortProperties: [ 'achievedAt' ]
  sortAscending: false
  
  actions:
    addAchievement: -> 
      data = @parseInput @get('newAchievement')
      achievement = @store.createRecord 'achievement',
        title: data['title']
        achievedAt: data['achievedAt']
      
      @set('newAchievement', '')
      achievement.save()

  parseInput: (str) ->
    day = /\bd\d\d\b/.exec(str)
    month = /\bm\d\d\b/.exec(str)
    year = /\by\d{4}\b/.exec(str)

    achievedAt = new Date()
    title = str

    if day
      title = title.replace(day[0], '')
      achievedAt.setDate(day[0].split('d')[1])
    if month
      title = title.replace(month[0], '')
      achievedAt.setMonth(parseInt(month[0].split('m')[1]) - 1 )
    if year 
      title = title.replace(year[0], '')
      achievedAt.setYear(parseInt(year[0].split('y')[1]))

    title.replace(/\s+/, ' ') if title

    {
      title: title,
      achievedAt: achievedAt
    }