$(document).on 'ready page:load', ->
  if $('#product-index-main').length > 0
    rails_env  = $('#product-index-main').data('rails-env')
    current_industry  = $('#product-index-main').data('current-industry')
    search_parameters = {}

    if current_industry.length > 0
      search_parameters = {
        facets: ['industries']
        facetsRefinements:
          industries: [ current_industry ]
      }

    search = instantsearch(
      appId: 'AJCEDEJVN8'
      apiKey: 'a79a1de365422bb69ce8b0b1af128e43'
      indexName: 'spree_products_' + rails_env
      searchParameters: search_parameters
      urlSync: {
        threshold: 300
        getHistoryState: ->
          { turbolinks: true }
      })

    search.on 'render', ->
      $('[data-toggle="tooltip"]').tooltip()

    noResultsTemplate = '<div class="text-center">No results found matching <strong>{{query}}</strong>.</div>'

    hitTemplate = '<div id="product_{{id}}" data-hook="products_list_item" itemscope="" itemtype="https://schema.org/Product" class="col-lg-3 col-md-4 col-sm-6 product-list-item"><div class="panel panel-default"><div class="panel-body text-center product-body"><a itemprop="url" href="https://www.safetygloves.com{{url}}"><img itemprop="image" alt="{{name}}" src="{{image}}"></a><a class="info" itemprop="name" title="{{name}}" href="https://www.safetygloves.com{{url}}">{{name}}</a></div><div class="panel-footer text-center"><span itemprop="offers" itemscope="" itemtype="https://schema.org/Offer"><span class="price selling lead" itemprop="price">${{price}}</span></span></div></div></div>'

    facetTemplateCheckbox = '<li class="facet_item {{#isRefined}}refined{{/isRefined}}"><input class="checkbox toggleRefine" data-facet="{{ facet }}" data-value="{{ name }}" type="checkbox" {{#isRefined}}checked{{/isRefined}}><a class="facet_link toggleRefine" data-facet="{{ facet }}" data-value="{{ name }}" href="#">{{ name }}</a><small class="facet_count text-muted pull-right">{{ count }}</small></li>'

    search.addWidget instantsearch.widgets.searchBox(
      container: '#q'
      placeholder: 'Search Products...')

    search.addWidget instantsearch.widgets.hits(
      container: '#hits'
      hitsPerPage: 24
      templates:
        empty: noResultsTemplate
        item: hitTemplate)

    search.addWidget instantsearch.widgets.pagination(
      container: '#pagination-wrap'
      cssClasses:
        root: 'pagination'
        active: 'active'
      labels:
        previous: '<i class="fa fa-angle-double-left" aria-hidden="true"></i> Prev'
        next: 'Next <i class="fa fa-angle-double-right" aria-hidden="true"></i>'
      showFirstLast: false
      autoHideContainer: true)

    search.addWidget instantsearch.widgets.clearAll(
      container: '#clear-all'
      excludeAttributes: 'industries'
      templates:
        link: 'Clear all filters <i class="fa fa-times" aria-hidden="true"></i>'
      cssClasses:
        link: 'btn btn-block btn-default clear-all-link'
      autoHideContainer: true)

    search.addWidget instantsearch.widgets.refinementList(
      container: '#product_type'
      attributeName: 'product_type'
      operator: 'and'
      limit: 10
      templates:
        item: facetTemplateCheckbox
        header: '<h3 class="panel-title">Product Type<i class="fa fa-plus fa-minus"></i></h3>'
      autoHideContainer: true
      cssClasses:
        root: "panel-root"
        body: "panel-body"
      collapsible:
        collapsed: false
    )

    search.addWidget instantsearch.widgets.refinementList(
      container: '#size'
      attributeName: 'size'
      operator: 'and'
      limit: 10
      templates:
        item: facetTemplateCheckbox
        header: '<h3 class="panel-title">Size<i class="fa fa-plus"></i></h3>'
      sortBy: ['count:desc']
      autoHideContainer: true
      cssClasses:
        root: "panel-root"
        body: "panel-body"
      collapsible:
        collapsed: true
    )

    search.addWidget instantsearch.widgets.refinementList(
      container: '#yuleys_size'
      attributeName: 'yuleys_size'
      operator: 'and'
      limit: 10
      templates:
        item: facetTemplateCheckbox
        header: '<h3 class="panel-title">Footwear Size<i class="fa fa-plus"></i></h3>'
      sortBy: ['name:asc']
      autoHideContainer: true
      cssClasses:
        root: "panel-root"
        body: "panel-body"
      collapsible:
        collapsed: true
    )

    search.addWidget instantsearch.widgets.refinementList(
      container: '#color'
      attributeName: 'color'
      operator: 'and'
      limit: 10
      templates:
        item: facetTemplateCheckbox
        header: '<h3 class="panel-title">Color<i class="fa fa-plus"></i></h3>'
      sortBy: ['name:asc']
      autoHideContainer: true
      cssClasses:
        root: "panel-root"
        body: "panel-body"
      collapsible:
        collapsed: true
    )

    search.addWidget instantsearch.widgets.refinementList(
      container: '#tint'
      attributeName: 'tint'
      operator: 'and'
      limit: 10
      templates:
        item: facetTemplateCheckbox
        header: '<h3 class="panel-title">Eyewear Tint<i class="fa fa-plus"></i></h3>'
      sortBy: ['name:asc']
      autoHideContainer: true
      cssClasses:
        root: "panel-root"
        body: "panel-body"
      collapsible:
        collapsed: true
    )

    search.addWidget instantsearch.widgets.refinementList(
      container: '#lens_coating'
      attributeName: 'lens_coating'
      operator: 'and'
      limit: 10
      templates:
        item: facetTemplateCheckbox
        header: '<h3 class="panel-title">Eyewear Coating<i class="fa fa-plus"></i></h3>'
      sortBy: ['name:asc']
      autoHideContainer: true
      cssClasses:
        root: "panel-root"
        body: "panel-body"
      collapsible:
        collapsed: true
    )

    search.addWidget instantsearch.widgets.currentRefinedValues(
      container: '#current-refined-values'
      attributes: [{name: 'product_type'}, {name: 'size'}, {name: 'yuleys_size'}, {name: 'color'}, {name: 'tint'}, {name: 'lens_coating'}]
      onlyListedAttributes: true
      clearAll: false
      templates:
        item: '<li>{{ name }}<i class="fa fa-times pull-right" aria-hidden="true"></i></li>'
        header: '<h3>Currently Selected</h3>'
      autoHideContainer: true)

    search.addWidget instantsearch.widgets.hitsPerPageSelector(
      container: '#hits-per-page-selector'
      cssClasses:
        root: 'form-control'
      options: [
        {
          value: 12
          label: '12 Products'
        }
        {
          value: 24
          label: '24 Products'
        }
        {
          value: 48
          label: '48 Products'
        }
        {
          value: 1000
          label: 'All Products'
        }
      ])

    search.start()

$(document).on 'click', '.facet-wrapper .list-unstyled', (e) ->
  this_panel = $(this).find('.panel-root')
  if this_panel.hasClass('ais-root__collapsed')
    this_panel.removeClass('ais-root__collapsed').find('.panel-title i').addClass('fa-minus')
  else
    this_panel.find('.panel-title i').removeClass('fa-minus')

$(document).on 'click', '#products.index .tint-square', (e) ->
  e.preventDefault()
  clicked_link = $(this)
  container_item = clicked_link.closest('.search-result-item')

  src = clicked_link.data('url')
  if src != undefined
    tint_img_wrap = container_item.find('.product-thumb')
    list = container_item.find('span.active').removeClass('active')
    clicked_link.addClass('active')

    tint_img_wrap.fadeOut 'fast', ->
      tint_img_wrap.empty().append '<img src="' + src + '" alt="">'
      tint_img_wrap.fadeIn 'fast'
      return
