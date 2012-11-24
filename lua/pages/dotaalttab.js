var hop = function(o, p){ return ({}).hasOwnProperty.call(o, p) }

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

    L.forIn(args, function(arg, value){
      if(arg === 'style'){
        L.forIn(value, function(sp, sv){
          node.style.setProperty(sp, sv);
        });
      }else{
        node.setAttribute(arg, value);
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

//Abbreviations
var E = DOM.ELEM,
    T = DOM.TEXT,
    H = DOM.HTML;

var SITE = {
  mk_show_hide_button: function(button, text_div){
    var button_text_node = button.childNodes[0];
    button.onclick = function(){
      var alt_text  = button.getAttribute('data-alt');
      var curr_text = button_text_node.nodeValue;
      
      DOM.toggleClass(text_div, 'hidden');
      
      button.setAttribute('data-alt', curr_text);
      button_text_node.nodeValue = alt_text;
      
    };
  }
};

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

SITE.mk_show_hide_button( DOM.byId('toggleAcks'), DOM.byId('acks') );

init_tabs();