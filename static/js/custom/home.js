$(".ads-container #cancel-icon").click(function() {
    $(".ads-container").fadeOut("slow");
});
let data = [{
    'username': 'TrustarScientist',
    'niche': "@education",
    "id": 3,
    "uuid": null,
    "category": 1,
    "poster": 2,
    "type": null,
    "title": "How Useful is WAEC Certificate InternationallyReally?",
    "date_created": "2023-01-28 05:55:53",
    "date_updated": "2023-01-2805:55:53",
    "slug": "How-Useful-is-WAEC-Certificate-Internationally-Really?",
    "content": "Why I go get to abroad and stillsit for SAT or IETS or GCSE to boost my career.",
    "views": 7566
}, {
    'username': 'Phychemma',
    'niche': "@affection",
    "id": 5,
    "uuid": null,
    "category": 2,
    "poster": 6,
    "type": null,
    "title": "Love is definitelybeatiful",
    "date_created": "2023-01-28 06:01:21",
    "date_updated": "2023-01-2806:01:21",
    "slug": "Love-is-definitely-beatiful",
    "content": "One beautiful thing about LOVE is this: it an important toolto cover our differences",
    "views": 83
}]
for (let a = data.length - 1; a > -1; a--) {
    let post = $('#template').clone()
    let children = post.children()
    children.first().children().eq(0).text(data[a].username)
    children.first().children().eq(2).text(data[a].date_created)
    children.eq(1).children().first().text(data[a].content)
    children.last().children().first().children().first().text(data[a].niche)
    $('[class="userposts"]').append(post.css("display", 'block'))
}