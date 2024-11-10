const mockSongsData = {
  "data": [
    {
      "id": 1,
      "title": "Blinding Lights",
      "artist": {"name": "The Weeknd"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/fd00ebd6d30d7253f813dba3bb1c66a9/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
    },
    {
      "id": 2,
      "title": "Levitating",
      "artist": {"name": "Dua Lipa"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/5d2b6a02f5e4d9ab4b6841f028f70057/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"
    },
    {
      "id": 3,
      "title": "Stay",
      "artist": {"name": "The Kid LAROI, Justin Bieber"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/f8fa2f01a50be2c8d68f97f31792a406/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"
    },
    {
      "id": 4,
      "title": "Good 4 U",
      "artist": {"name": "Olivia Rodrigo"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/d7e8a0f836c0d8f8cfc2e48ff9b0419e/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3"
    },
    {
      "id": 5,
      "title": "Montero (Call Me By Your Name)",
      "artist": {"name": "Lil Nas X"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/8f8a0a96ab1b1b6a5be3bbd57e9b8c3e/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3"
    },
    {
      "id": 6,
      "title": "Industry Baby",
      "artist": {"name": "Lil Nas X, Jack Harlow"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/11bc548d3d058ec80344b7c64f19e7a2/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3"
    },
    {
      "id": 7,
      "title": "Save Your Tears",
      "artist": {"name": "The Weeknd"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/fd00ebd6d30d7253f813dba3bb1c66a9/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3"
    },
    {
      "id": 8,
      "title": "Kiss Me More",
      "artist": {"name": "Doja Cat, SZA"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/cb877ac10d62fefce1bc3f9f88b26857/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3"
    },
    {
      "id": 9,
      "title": "Peaches",
      "artist": {"name": "Justin Bieber, Daniel Caesar, Giveon"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/9efed705a6d967b8b6653a5205c6edbe/250x250-000000-80-0-0.jpg"
      },
      "preview": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3"
    },
    {
      "id": 10,
      "title": "Heat Waves",
      "artist": {"name": "Glass Animals"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/5c6806faeb21ed1e823ed4e6a12ec97f/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3"
    },
    {
      "id": 11,
      "title": "Shivers",
      "artist": {"name": "Ed Sheeran"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/eb85ef0fd1a7245ca0e0434287b29944/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3"
    },
    {
      "id": 12,
      "title": "Bad Habits",
      "artist": {"name": "Ed Sheeran"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/eb85ef0fd1a7245ca0e0434287b29944/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3"
    },
    {
      "id": 13,
      "title": "Deja Vu",
      "artist": {"name": "Olivia Rodrigo"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/d7e8a0f836c0d8f8cfc2e48ff9b0419e/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3"
    },
    {
      "id": 14,
      "title": "Good 4 U",
      "artist": {"name": "Olivia Rodrigo"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/d7e8a0f836c0d8f8cfc2e48ff9b0419e/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3"
    },
    {
      "id": 15,
      "title": "Blinding Lights",
      "artist": {"name": "The Weeknd"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/fd00ebd6d30d7253f813dba3bb1c66a9/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3"
    },
    {
      "id": 16,
      "title": "Save Your Tears",
      "artist": {"name": "The Weeknd"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/fd00ebd6d30d7253f813dba3bb1c66a9/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3"
    },
    {
      "id": 17,
      "title": "Levitating",
      "artist": {"name": "Dua Lipa"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/5d2b6a02f5e4d9ab4b6841f028f70057/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-17.mp3"
    },
    {
      "id": 18,
      "title": "Stay",
      "artist": {"name": "The Kid LAROI, Justin Bieber"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/f8fa2f01a50be2c8d68f97f31792a406/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-18.mp3"
    },
    {
      "id": 19,
      "title": "Peaches",
      "artist": {"name": "Justin Bieber, Daniel Caesar, Giveon"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/9efed705a6d967b8b6653a5205c6edbe/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-19.mp3"
    },
    {
      "id": 20,
      "title": "Heat Waves",
      "artist": {"name": "Glass Animals"},
      "album": {
        "cover_medium":
            "https://e-cdns-images.dzcdn.net/images/cover/5c6806faeb21ed1e823ed4e6a12ec97f/250x250-000000-80-0-0.jpg"
      },
      "preview":
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-20.mp3"
    }
  ]
};
