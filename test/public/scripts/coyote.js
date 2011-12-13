(function() {
  this.module = function(names, fn) {
    var space, _name;
    if (typeof names === 'string') {
      names = names.split('.');
    }
    space = this[_name = names.shift()] || (this[_name] = {});
    space.module || (space.module = this.module);
    if (names.length) {
      return space.module(names, fn);
    } else {
      return fn.call(space);
    }
  };
}).call(this);


(function() {
  this.module("Keystone", function() {
    return this.Forms = (function() {
      function Forms($form) {
        this.build();
      }
      Forms.prototype.build = function() {
        if (!Keystone.elementSupportsAttribute('input', 'placeholder')) {
          return $('input[placeholder]').each(function() {
            var $input, placeholder;
            $input = $(this);
            placeholder = $input.attr('placeholder');
            $input.val(placeholder).addClass('inactive');
            return $input.bind({
              focus: function() {
                if ($input.val() === placeholder) {
                  return $input.val('').removeClass('inactive');
                }
              },
              blur: function() {
                if ($input.val() === '') {
                  return $input.val(placeholder).addClass('inactive');
                }
              }
            });
          });
        }
      };
      return Forms;
    })();
  });
}).call(this);


(function() {
  Keystone.elementSupportsAttribute = function(element, attribute) {
    return attribute in document.createElement(element);
  };
}).call(this);


(function() {
  this.module("ClientName", function() {
    return this.Interface = (function() {
      function Interface() {
        this.build();
      }
      Interface.prototype.build = function() {
        return new Keystone.Forms;
      };
      return Interface;
    })();
  });
}).call(this);


(function() {
  this.module("ClientName", function() {
    return this.main = function() {
      return this.interface = new ClientName.Interface;
    };
  });
}).call(this);


(function() {
  $(function() {
    return ClientName.main();
  });
}).call(this);


../../assets/javascripts/app/confio/interface.js../../assets/javascripts/app/confio/main.js



