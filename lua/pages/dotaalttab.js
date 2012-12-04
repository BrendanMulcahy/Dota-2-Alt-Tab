var hop = function(o, p){ return ({}).hasOwnProperty.call(o, p) }

var KW = {
  //For functions with named arguments
  
  get: function(kw, arg){
    if(hop(kw, arg)){
      return kw[arg];
    }else{
      throw new Error('missing argument '+arg);
    }
  },
  
  opt: function(kw, arg, opt){
    if(hop(kw, arg)){
      return kw[arg];
    }else{
      return opt;
    }
  }
};

var L = {
  //List functions

  forIn: function(obj, f){
    for(var k in obj) if(hop(obj, k)){
      f.call(this, k, obj[k], obj);
    }
  },

  forEach: function(xs, f){
    for(var i=0, l=xs.length; i<l; i++){
      f.call(this, xs[i], i, xs)
    }
  },
  
  map: function(xs, f){
    var res = [];
    for(var i=0, l=xs.length; i<l; i++){
      res[i] = f.call(this, xs[i], i, xs)
    }
    return res;
  },
  
  filter: function(xs, f){
    var res = [];
    for(var i=0, l=xs.length; i<l; i++){
      if(f(xs[i])){ res.push(xs[i]) }
    }
    return res;
  },

  contains: function(xs, x){
    for(var i=0, l=xs.length; i<l; i++){
      if(xs[i] === x){ return true }
    }
    return false;
  },

  isArray: function(list){
    //Note: This function does not work on arrays created in other windows
    // or on array-like objects (like `arguments`)
    return list instanceof Array;
  },

  flatten: function(xs){
    var res = [];
    
    function go(xs){
      if(L.isArray(xs)){
        L.forEach(xs, go);
      }else{
        res.push(xs);
      }
    }
  
    go(xs);
  
    return res;
  }
};

var RE = (function(){
  //Regular Expression functions
  
  var specialChars = ['.', '*', '+', '?', '|', '(', ')', '[', ']', '-', '{', '}', '\\', '$', '^'];
  var addSlash = function(c){ return '\\' + c };
  
  var specialCharsRe = new RegExp(
    '(' + L.map(specialChars, addSlash).join('|') + ')',
    'g'
  );

  return {
    escape : function(src){ return src.replace(specialCharsRe, addSlash) }
  }
  
}());


var DOM = {

  //Query
  
  byId: function(id){  return document.getElementById(id) },
  qsa : function(qry){ return document.querySelectorAll(qry) },

  //Node Manipulation
  
  rn : function(n1){ return n1.parentNode.removeChild(n1) },

  insc : function(n1, n2){ return n1.appendChild(n2) },

  insa : function(n1, n2){ return n1.parentNode.insertBefore(n2, n1.nextSibling) },
  insb : function(n1, n2){ return n1.parentNode.insertBefore(n2, n1) },

  clrn : function(node){
    var cs = node.childNodes;
    for(var i=cs.length-1; i>=0; i--){
      node.removeChild(cs[i]);
    }
  },

  inscs : function(n1, ns){
    L.forEach(ns, function(n2){ DOM.insc(n1, n2) });
  },

  replc : function(n1, ns){
    DOM.clrn(n1); DOM.inscs(n1, ns);
  },

  //CSS classes
  
  hasClass: function(node, cls){
    return L.contains(DOM.getClasses(node), cls);
  },
  
  getClasses: function(node){
    return node.className.split(' ');
  },
  
  setClasses: function(node, classes){
    node.className = classes.join(' ');
  },
  
  addClass: function(node, cls){
    var classes = DOM.getClasses(node);
    if(!L.contains(classes, cls)){
      classes.push(cls);
      DOM.setClasses(node, classes);
    }
  },
  
  removeClass: function(node, cls){
    var classes = DOM.getClasses(node);
    if(L.contains(classes, cls)){
      DOM.setClasses(node, L.filter(classes, function(c){ c !== cls }));
    }
  },
  
  toggleClass: function(node, cls){
    if(DOM.hasClass(node, cls)){
      DOM.removeClass(node, cls);
    }else{
      DOM.addClass(node, cls);
    }
  },
  
  //Node creation
  
  ELEM : function(tagname, attrs, children){
    //Create an element node, given its attributes and child nodes
    // The children array can be an array of arrays (so we can put HTML() there)
    
    if(arguments.length === 1){
      children = []; attrs = {};
    }else if(arguments.length === 2){
      if(L.isArray(attrs)){
        children = attrs; attrs = {}
      }else{
        children = []; attrs = attrs;
      }
    }
    
    var node = document.createElement(tagname);

    L.forIn(attrs, function(attr, value){
      if(attr === 'style'){
        L.forIn(value, function(sp, sv){
          node.style.setProperty(sp, sv);
        });
      }else{
        node.setAttribute(attr, value);
      }
    });
    
    L.forEach(L.flatten(children), function(c){
      if(c){ node.appendChild(c); }
    });
    
    return node;
  },

  TEXT : function(text){
    return document.createTextNode(text);
  },

  HTML : function(html){
    //Create a list of nodes given their HTML serialization.
    var d = document.createElement('div');
    d.innerHTML = html;
    var nodes = [], cs = d.childNodes;
    for(var i=cs.length-1; i>=0; i--){
      nodes[i] = cs[i];
      d.removeChild(cs[i]);
    }
    return nodes;
  }
};

var EVT = {
  getKeyCode: function(evt){
    return (evt ? evt.which : alert("I haven't coded for IE yet.") );
  },
  
  onHashChange: function(onChange){
    
    if('onhashchange' in window){
      window.onhashchange = function(){
        return onChange(window.location.hash);
      }
    }else{
      var oldHash = window.location.hash;
      setInterval(function(){
        var newHash = window.location.hash;
        if(oldHash !== newHash){
          oldHash = newHash;
          onChange(newHash);
        }
      }, 1000);
    }
  }
};

//Abbreviations
var E = DOM.ELEM,
    T = DOM.TEXT,
    H = DOM.HTML;

var AUTOCOMPLETE = {
  create: function(input_field, kw){
    
    var minimum_chars = KW.opt(kw, 'minimum_chars', 1),
        fetch_items = KW.get(kw, 'fetch_items'),
        render_item = KW.get(kw, 'render_item'),
        display_items = KW.get(kw, 'display_items'),
        select_item = KW.get(kw, 'select_item');
  
    // State
    
    var selected_row_index,
        visible_items,
        visible_rows;
    
    // Getters
    
    var is_valid_index = function(i){
      return (i !== null) && (0 <= i && i < visible_rows.length);
    };
    
    var selected_item = function(){
      return (is_valid_index(selected_row_index) ? visible_items[selected_row_index] : null);
    };
    
    var selected_row = function(){
      return (is_valid_index(selected_row_index) ? visible_rows[selected_row_index] : null);
    };
    
    // State Manipulation
    
    var reset_rows = function(items){
      selected_row_index = null;
      
      visible_items = items;
      
      visible_rows = L.map(items, render_item);
      L.forEach(items, function(item, i){
        visible_rows[i].onclick = function(){ select_item(item) };
      });
      
      display_items(visible_rows);
      
      if(items.length > 0){
        select_row(0);
      }
    };
    
    var select_row = function(new_i){
      if(!is_valid_index(new_i)){ return false }

      var old_row = selected_row();
      if(old_row){
        DOM.removeClass(old_row, 'selected');
      }
      
      selected_row_index = new_i
        
      new_row = selected_row();
      DOM.addClass(new_row, 'selected');
    };
    
    var move_up   = function(){ select_row(selected_row_index - 1) };
    var move_down = function(){ select_row(selected_row_index + 1) };
    
    //Autocomplete
    
    var update_sugestions = function(partial_name){
      
      if(partial_name.length < minimum_chars){
        reset_rows([]);
        return;
      }
      
      reset_rows( fetch_items(partial_name) );
    };
    
    //Initialize
    
    reset_rows([]);
    
    input_field.onkeydown = function(evt){
      var keycode = EVT.getKeyCode(evt);
      
      //console.log('down', keycode)
      
      switch(keycode){
        case 9 /*TAB*/:
          break;
        
        case 13 /*ENTER*/:
          break;
      
        case 38 /*UP*/  :
          move_up(); return false;
        case 40 /*DOWN*/:
          move_down(); return false;
        
        case 39 /*RIGHT*/: break;
        case 37 /*LEFT*/: break;
        default: break;
      }
    };

    input_field.onkeyup = function(evt){
      var keycode = EVT.getKeyCode(evt);
      
      //console.log('up', keycode)
      
      switch(keycode){
        case 9 /*TAB*/:
          break;
        
        case 13 /*ENTER*/:
          var item = selected_item();
          if(item){ select_item(item) }
          break;
        
        case 38 /*UP*/: break;
        case 40 /*DOWN*/: break;
      
        case 39 /*RIGHT*/: break;
        case 37 /*LEFT*/: break
          
        default:
          update_sugestions(input_field.value);
          break;
      }
    }
    
    return {
      update: function(value){
        input_field.value = value;
        update_sugestions(input_field.value);
      }
    }
  }
};

var SITE = (function(){ "use strict"; return {
  
  mk_show_hide_button: function(button, text_div){
    
    var button_text_node = button.childNodes[0];
    button.onclick = function(){
      var alt_text  = button.getAttribute('data-alt');
      var curr_text = button_text_node.nodeValue;
      
      DOM.toggleClass(text_div, 'hidden');
      
      button.setAttribute('data-alt', curr_text);
      button_text_node.nodeValue = alt_text;
      
    };
  },
  
  mk_hero_autocomplete: function(hero_data, pattern_data){
    
    var autocomplete_div, autocomplete_input, results_table;
    
    autocomplete_div = E('div', {'class': 'autocomplete'}, [
      E('table', {'class':'autocomplete-input'}, [
        E('tr', [
          E('td', {'class': 'label'},
            [E('label', {'for':'hero_search'}, T("Find your hero:"))]),
          E('td',
            [(autocomplete_input =
              E('input', {type:'text', id:'hero_search'})) ])
        ])
      ]),
      (results_table =
       E('table', {'class':'autocomplete-results'}))
    ]);
    

    
    var autocomplete = AUTOCOMPLETE.create(autocomplete_input, {
      minimum_chars: 1,
  
      fetch_items: function(partial_name){
        
        var first_prefix_matches  = [], //Prefix of the full name.
            middle_prefix_matches = [], //Prefix of some inner word.
            anywhere_matches      = []; //Any match.
        
        //Allow apostrophes to be ommited.
        var name_re_src = L.map(partial_name, function(c){ return RE.escape(c) + "'*" }).join('');
        
        var matches_to_try = [
          {list:first_prefix_matches,  regex:new RegExp('^'       + '(' + name_re_src + ')', 'i')},
          {list:middle_prefix_matches, regex:new RegExp('[\\s\-]' + '(' + name_re_src + ')', 'i')},
          {list:anywhere_matches,      regex:new RegExp(            '(' + name_re_src + ')', 'i')}
        ];
          
        L.forEach(pattern_data, function(o){
          var hid = o.id,
              pat = o.pat;
          
          L.forEach(matches_to_try, function(m){
            var list = m.list, regex = m.regex;
            var match = pat.match(regex);
            if(match){ list.push({patdata:o, match:match[1]}) }
          });
        });
        
        var used_heroes = {};
        var results = [];
      
        var add_match = function(om){
          var hid = om.patdata.id;
          if(!hop(used_heroes, hid)){
            used_heroes[hid] = true;
            results.push(om);
          }
        };
        
        L.forEach(first_prefix_matches, add_match);
        L.forEach(middle_prefix_matches, add_match);
        if(first_prefix_matches.length === 0 && middle_prefix_matches.length == 0){
          L.forEach(anywhere_matches, add_match);
        }
        
        return results;
      },
      
      render_item: function(om){
        var o     = om.patdata,
            match = om.match;
        
        var hid = o.id,
            pat = o.pat,
            rem = o.rem;
        
        var sprite_html = hero_data[hid].sprite;

        var before = pat.substr(0, pat.indexOf(match));
        var after  = pat.substr(pat.indexOf(match)+match.length, pat.length);
        
        return (
          E('tr', [
            E('td', {'class':'image_column'}, H(sprite_html)),
            E('td', {'class':'name_column'}, [
              E('strong', [
                T(before),
                E('span', {'class':'pattern'}, [T(match)]),
                T(after)
              ]),
              T(rem ? ' ('+rem+')' : '' ),
              E('span', {'class':'navigation'},[
                T('Go to guide')
              ])
            ])
          ])
        );
      },
      
      display_items: function(nodes){
        DOM.replc(results_table, nodes);
      },
      
      select_item: function(om){
        location.href = hero_data[om.patdata.id].link;
      }
    });
    
    return {
      getNode: function(){ return autocomplete_div },
      getValue: function(){ return autocomplete_input.value },
      setValue: function(v){ autocomplete.update(v) }
    };
  }
}

}());

var mk_tab_onclick = function(ix, tabs, panes){
    return function(){
        for(var i=0; i<tabs.length; i++){
            var tab = tabs[i];
            tab.className = (i === ix ?  "tab active" : "tab inactive")
        }
        
        for(var i=0; i<panes.length; i++){
            var pane = panes[i];
            pane.className = (i === ix ?  "pane visible" : "pane hidden")
        }
    }
};

var init_tabs = function(){
    var divs = document.getElementsByTagName('div');
    for(var i=0; i<divs.length; i++){
        var div = divs[i];
        if(div.className === 'tabs'){
            var tabs = [];
            var panes = [];
            for(var node=div.firstChild; node; node=node.nextSibling){
                if(/^tab/.test(node.className)){
                   tabs.push(node);
                }else if(/^pane/.test(node.className)){
                   panes.push(node);
                }
            }
            for(var j=0; j<tabs.length; j++){
                tabs[j].onclick = mk_tab_onclick(j, tabs, panes);
            }
        }
    }
};

//

//Main function:
//(function(){
  
  SITE.mk_show_hide_button( DOM.byId('toggleAcks'), DOM.byId('acks') );

  init_tabs();

  var autocomplete = SITE.mk_hero_autocomplete(DATA.heroes, DATA.patterns);
  
  var tavs = DOM.qsa('div.taverns')[0];
  DOM.insb(tavs.firstChild, autocomplete.getNode());

  EVT.onHashChange(function(){
    autocomplete.setValue('');
  });
  
//}());