// comments made by 
// CODE COMMENTS CANNOT BE ADDED TO THE ACTUAL MANIFEST FILE, THIS A COPY OF THE ORIGINAL BEING USED FOR EXPLAINING THINGS.
// PLEASE EDIT THE ACTUAL MANIFEST FILE

// The manifest file basically tells the game what each entity and script file relates to using their given IDs.
// For example, it tells the game that the script file with the "fraynkieCharacterStats" ID is actually the character's main stats.

{
  // Make the resource ID something unique, it determines the name of the character's .fra file when you export them.
  "resourceId": "fraynkie",
  "content": [{
    // All entities have an ID that can be called upon for spawning them in.
    "id": "fraynkie",
    "name": "Fraynkie",
    "description": "Just a sweet little baby",
    "type": "character",

    // Scripts also have IDs, here they need to match the ID assigned to their actual file.
    // There's no real reason to actually change the character related IDs at all, but you can if you want.
    //    Personally, I'd recommend it for organization (-Thielith)
    "objectStatsId": "fraynkieCharacterStats",     // The entity's object stats script
    "animationStatsId": "fraynkieAnimationStats",  // The entity's animation stats script
    "hitboxStatsId": "fraynkieHitboxStats",        // The entity's attack hitbox stats script
    "scriptId": "fraynkieScript",                  // The entity's main script
    "costumesId": "fraynkieCostumes",              // The entity's palette file
    "aiId": "fraynkieAi",                          // A character's custom AI script
    "metadata": {
      "ui":{
        "entityId":"menu",
        "render":{
          "animation":"full",
          "animation_icon":"icon",
          "animation_icon_no_palette":"icon_no_palette",
          
          // Positive X: To the left, Negative X: To the right, Postive Y: Upwards, Negative Y: Downards
          // How far the character's portrait should be adjusted from the origin point (0,0) on the character select screen.
          "x_offset": 0,
          "y_offset": 38,
          // How far the character's portrait should be adjusted from the origin point (0,0) on the screen right after you choose a stage.
          "x_offset_door": 0,
          "y_offset_door": 0,
          // How far the character's portrait should be adjusted from the origin point (0,0) on the screen right after you choose a stage, but when it's not a 1v1.
          "x_offset_door_ffa": 0,
          "y_offset_door_ffa": 0
        },
        "hud":{
          "animation":"hud_neutral",
          "animation_front": "hud_neutral_front",
          "animation_happy":"hud_happy",
          "animation_happy_front":"hud_happy_front",
          "animation_sad":"hud_sad",
          "animation_sad_front":"hud_sad_front",
          "animation_angry":"hud_angry",
          "animation_angry_front":"hud_angry_front",
          "animation_hurt":"hud_hurt",
          "animation_hurt_front":"hud_hurt_front",
          "animation_stock_icon": "stock"
        },
        "css":{
          "animation":"css",
          "info":{
            "game":"Fraymakers (Early Access)",
            "description":"Just a sweet little baby."
          }
        }
      }
    }
  },{
    // Unlike the other main scripts, the character's custom AI script is technically a seperate thing from the character itself.
    "id": "fraynkieAi",
    "type": "characterAi",
    "scriptId": "fraynkieAiScript"
  },{
    // The projectile Fraynkie uses for neutral special. As it's a different entity from the character, it has its own unique IDs for the entity and scripts.
    "id": "fraynkieProjectile",
    "type": "projectile",
    "objectStatsId": "fraynkieProjectileStats",
    "animationStatsId": "fraynkieProjectileAnimationStats",
    "hitboxStatsId": "fraynkieProjectileHitboxStats",
    "scriptId": "fraynkieProjectileScript",
    "costumesId": "fraynkieCostumes"
  }]
}