# Convert a recipe to BeerXML 1.0
Brauhaus.Recipe::toBeerXml = ->
    xml = '<?xml version="1.0" encoding="utf-8"?><recipes><recipe>'

    xml += '<version>1</version>'
    xml += "<name>#{@name}</name>"
    xml += "<brewer>#{@author}</brewer>"
    xml += "<batch_size>#{@batchSize}</batch_size>"
    xml += "<boil_size>#{@boilSize}</boil_size>"
    xml += "<efficiency>#{@mashEfficiency}</efficiency>"

    if @primaryDays
        xml += "<primary_age>#{@primaryDays}</primary_age>"
    if @primaryTemp
        xml += "<primary_temp>#{@primaryTemp}</primary_temp>"

    if @secondaryDays
        xml += "<secondary_age>#{@secondaryDays}</secondary_age>"
    if @secondaryTemp
        xml += "<secondary_temp>#{@secondaryTemp}</secondary_temp>"

    if @tertiaryDays
        xml += "<tertiary_age>#{@tertiaryDays}</tertiary_age>"
    if @tertiaryTemp
        xml += "<tertiary_temp>#{@tertiaryTemp}</tertiary_temp>"

    if @agingDays
        xml += "<age>#{@agingDays}</age>"
    if @agingTemp
        xml += "<age_temp>#{@agingTemp}</age_temp>"

    if @bottlingTemp
        xml += "<carbonation_temp>#{@bottlingTemp}</carbonation_temp>"
    if @bottlingPressure
        xml += "<carbonation>#{@bottlingPressure}</carbonation>"

    if @style
        xml += '<style><version>1</version>'
        
        xml += "<name>#{@style.name}</name>" if @style.name
        xml += "<category>#{@style.category}</category>" if @style.category
        xml += "<og_min>#{@style.og[0]}</og_min><og_max>#{@style.og[1]}</og_max>"
        xml += "<fg_min>#{@style.fg[0]}</fg_min><fg_max>#{@style.fg[1]}</fg_max>"
        xml += "<ibu_min>#{@style.ibu[0]}</ibu_min><ibu_max>#{@style.ibu[1]}</ibu_max>"
        xml += "<color_min>#{@style.color[0]}</color_min><color_max>#{@style.color[1]}</color_max>"
        xml += "<abv_min>#{@style.abv[0]}</abv_min><abv_max>#{@style.abv[1]}</abv_max>"
        xml += "<carb_min>#{@style.carb[0]}</carb_min><carb_max>#{@style.carb[1]}</carb_max>"
        xml += '</style>'

    xml += '<fermentables>'
    for fermentable in @fermentables
        xml += '<fermentable><version>1</version>'
        xml += "<name>#{ fermentable.name }</name>"
        xml += "<type>#{ fermentable.type() }</type>"
        xml += "<weight>#{ fermentable.weight.toFixed 1 }</weight>"
        xml += "<yield>#{ fermentable.yield.toFixed 1 }</yield>"
        xml += "<color>#{ fermentable.color.toFixed 1 }</color>"
        xml += '</fermentable>'
    xml += '</fermentables>'

    xml += '<hops>'
    for hop in @spices.filter((item) -> item.aa > 0)
        xml += '<hop><version>1</version>'
        xml += "<name>#{ hop.name }</name>"
        xml += "<time>#{ hop.time }</time>"
        xml += "<amount>#{ hop.weight }</amount>"
        xml += "<alpha>#{ hop.aa.toFixed 2 }</alpha>"
        xml += "<use>#{ hop.use }</use>"
        xml += "<form>#{ hop.form }</form>"
        xml += '</hop>'
    xml += '</hops>'

    xml += '<yeasts>'
    for yeast in @yeast
        xml += '<yeast><version>1</version>'
        xml += "<name>#{ yeast.name }</name>"
        xml += "<type>#{ yeast.type }</type>"
        xml += "<form>#{ yeast.form }</form>"
        xml += "<attenuation>#{ yeast.attenuation }</attenuation>"
        xml += '</yeast>'
    xml += '</yeasts>'

    xml += '<miscs>'
    for misc in @spices.filter((item) -> item.aa is 0)
        xml += '<misc><version>1</version>'
        xml += "<name>#{ misc.name }</name>"
        xml += "<time>#{ misc.time }</time>"
        xml += "<amount>#{ misc.weight }</amount>"
        xml += "<use>#{ misc.use }</use>"
        xml += '</misc>'
    xml += '</miscs>'

    if @mash
        xml += '<mash><version>1</version>'
        xml += "<name>#{@mash.name}</name>"
        xml += "<grain_temp>#{@mash.grainTemp}</grain_temp>"
        xml += "<sparge_temp>#{@mash.spargeTemp}</sparge_temp>"
        xml += "<ph>#{@mash.ph}</ph>"
        xml += "<notes>#{@mash.notes}</notes>"

        xml += '<mash_steps>'
        for step in @mash.steps
            xml += '<mash_step><version>1</version>'
            xml += "<name>#{step.name}</name>"
            xml += "<description>#{step.description(true, @grainWeight())}</description>"
            xml += "<step_time>#{step.time}</step_time>"
            xml += "<step_temp>#{step.temp}</step_temp>"
            xml += "<end_temp>#{step.endTemp}</end_temp>"
            xml += "<ramp_time>#{step.rampTime}</ramp_time>"

            if step.type is 'Decoction'
                xml += "<decoction_amt>#{step.waterRatio * @grainWeight()}</decoction_amt>"
            else
                xml += "<infuse_amount>#{step.waterRatio * @grainWeight()}</infuse_amount>"

            xml += '</mash_step>'
        xml += '</mash_steps>'

        xml += '</mash>'

    xml += '</recipe></recipes>'
