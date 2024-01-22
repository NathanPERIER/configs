
# Terminal configuration

Since it is difficult to programatically setup most terminals' configurations, this repository assumes that it is done manually each time. 

## Themes

Some colour themes are located in `colours`. They are formatted as JSON, using the Windows Terminal structure since it is the only terminal that accepts JSON (to the author's knowledge).

## Windows terminal

Edit the existing configuration with the following values :

```json
{
    "profiles": {
        "defaults": {
            "bellStyle": "none",
            "font": {
                "face": "Fira Code",
                "size": 11.0
            }
        }
    }
}
```

(additionally, refer to the previous section for colour schemes)

