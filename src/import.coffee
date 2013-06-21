# Get a list of parsed recipes from BeerXML input
Brauhaus.Recipe.fromBeerXml = (xml) ->
    recipes = []
    parser = new DOMParser()
    doc = parser.parseFromString xml, 'text/xml'
    
    for recipeNode in doc.documentElement.childNodes or []
        if recipeNode.nodeName.toLowerCase() isnt 'recipe'
            continue

        recipe = new Brauhaus.Recipe()

        for recipeProperty in recipeNode.childNodes or []
            switch recipeProperty.nodeName.toLowerCase()
                when 'name'
                    recipe.name = recipeProperty.textContent
                when 'brewer'
                    recipe.author = recipeProperty.textContent
                when 'batch_size'
                    recipe.batchSize = parseFloat recipeProperty.textContent
                when 'boil_size'
                    recipe.boilSize = parseFloat recipeProperty.textContent
                when 'efficiency'
                    recipe.mashEfficiency = parseFloat recipeProperty.textContent
                when 'primary_age'
                    recipe.primaryDays = parseFloat recipeProperty.textContent
                when 'primary_temp'
                    recipe.primaryTemp = parseFloat recipeProperty.textContent
                when 'secondary_age'
                    recipe.secondaryDays = parseFloat recipeProperty.textContent
                when 'secondary_temp'
                    recipe.secondaryTemp = parseFloat recipeProperty.textContent
                when 'tertiary_age'
                    recipe.tertiaryDays = parseFloat recipeProperty.textContent
                when 'tertiary_temp'
                    recipe.tertiaryTemp = parseFloat recipeProperty.textContent
                when 'carbonation'
                    recipe.bottlingPressure = parseFloat recipeProperty.textContent
                when 'carbonation_temp'
                    recipe.bottlingTemp = parseFloat recipeProperty.textContent
                when 'age'
                    recipe.agingDays = parseFloat recipeProperty.textContent
                when 'age_temp'
                    recipe.agingTemp = parseFloat recipeProperty.textContent
                when 'style'
                    recipe.style =
                        og: [1.000, 1.150]
                        fg: [1.000, 1.150]
                        ibu: [0, 150]
                        color: [0, 500]
                        abv: [0, 14]
                        carb: [1.0, 4.0]
                    for styleNode in recipeProperty.childNodes or []
                        switch styleNode.nodeName.toLowerCase()
                            when 'name'
                                recipe.style.name = styleNode.textContent
                            when 'category'
                                recipe.style.category = styleNode.textContent
                            when 'og_min'
                                recipe.style.og[0] = parseFloat styleNode.textContent
                            when 'og_max'
                                recipe.style.og[1] = parseFloat styleNode.textContent
                            when 'fg_min'
                                recipe.style.fg[0] = parseFloat styleNode.textContent
                            when 'fg_max'
                                recipe.style.fg[1] = parseFloat styleNode.textContent
                            when 'ibu_min'
                                recipe.style.ibu[0] = parseFloat styleNode.textContent
                            when 'ibu_max'
                                recipe.style.ibu[1] = parseFloat styleNode.textContent
                            when 'color_min'
                                recipe.style.color[0] = parseFloat styleNode.textContent
                            when 'color_max'
                                recipe.style.color[1] = parseFloat styleNode.textContent
                            when 'abv_min'
                                recipe.style.abv[0] = parseFloat styleNode.textContent
                            when 'abv_max'
                                recipe.style.abv[1] = parseFloat styleNode.textContent
                            when 'carb_min'
                                recipe.style.carb[0] = parseFloat styleNode.textContent
                            when 'carb_max'
                                recipe.style.carb[1] = parseFloat styleNode.textContent
                when 'fermentables'
                    for fermentableNode in recipeProperty.childNodes or []
                        if fermentableNode.nodeName.toLowerCase() isnt 'fermentable'
                            continue

                        fermentable = new Brauhaus.Fermentable()

                        for fermentableProperty in fermentableNode.childNodes or []
                            switch fermentableProperty.nodeName.toLowerCase()
                                when 'name'
                                    fermentable.name = fermentableProperty.textContent
                                when 'amount'
                                    fermentable.weight = parseFloat fermentableProperty.textContent
                                when 'yield'
                                    fermentable.yield = parseFloat fermentableProperty.textContent
                                when 'color'
                                    fermentable.color = parseFloat fermentableProperty.textContent
                                when 'add_after_boil'
                                    fermentable.late = fermentableProperty.textContent.toLowerCase() == 'true'

                        recipe.fermentables.push fermentable
                when 'hops', 'miscs'
                    for spiceNode in recipeProperty.childNodes or []
                        if spiceNode.nodeName.toLowerCase() not in ['hop', 'misc']
                            continue

                        spice = new Brauhaus.Spice()

                        for spiceProperty in spiceNode.childNodes or []
                            switch spiceProperty.nodeName.toLowerCase()
                                when 'name'
                                    spice.name = spiceProperty.textContent
                                when 'amount'
                                    spice.weight = parseFloat spiceProperty.textContent
                                when 'alpha'
                                    spice.aa = parseFloat spiceProperty.textContent
                                when 'use'
                                    spice.use = spiceProperty.textContent
                                when 'form'
                                    spice.form = spiceProperty.textContent

                        recipe.spices.push spice
                when 'yeasts'
                    for yeastNode in recipeProperty.childNodes or []
                        if yeastNode.nodeName.toLowerCase() isnt 'yeast'
                            continue

                        yeast = new Brauhaus.Yeast()

                        for yeastProperty in yeastNode.childNodes or []
                            switch yeastProperty.nodeName.toLowerCase()
                                when 'name'
                                    yeast.name = yeastProperty.textContent
                                when 'type'
                                    yeast.type = yeastProperty.textContent
                                when 'form'
                                    yeast.form = yeastProperty.textContent
                                when 'attenuation'
                                    yeast.attenuation = parseFloat yeastProperty.textContent

                        recipe.yeast.push yeast
                when 'mash'
                    mash = recipe.mash = new Brauhaus.Mash()

                    for mashProperty in recipeProperty.childNodes or []
                        switch mashProperty.nodeName.toLowerCase()
                            when 'name'
                                mash.name = mashProperty.textContent
                            when 'grain_temp'
                                mash.grainTemp = parseFloat mashProperty.textContent
                            when 'sparge_temp'
                                mash.spargeTemp = parseFloat mashProperty.textContent
                            when 'ph'
                                mash.ph = parseFloat mashProperty.textContent
                            when 'notes'
                                mash.notes = mashProperty.textContent
                            when 'mash_steps'
                                for stepNode in mashProperty.childNodes or []
                                    if stepNode.nodeName.toLowerCase() isnt 'mash_step'
                                        continue

                                    step = new Brauhaus.MashStep()

                                    for stepProperty in stepNode.childNodes or []
                                        switch stepProperty.nodeName.toLowerCase()
                                            when 'name'
                                                step.name = stepProperty.textContent
                                            when 'type'
                                                step.type = stepProperty.textContent
                                            when 'infuse_amount'
                                                step.waterRatio = parseFloat(stepProperty.textContent) / recipe.grainWeight()
                                            when 'step_temp'
                                                step.temp = parseFloat stepProperty.textContent
                                            when 'end_temp'
                                                step.endTemp = parseFloat stepProperty.textContent
                                            when 'step_time'
                                                step.time = parseFloat stepProperty.textContent
                                            when 'decoction_amt'
                                                step.waterRatio = parseFloat(stepProperty.textContent) / recipe.grainWeight()

                                    mash.steps.push step

        recipes.push recipe

    recipes
