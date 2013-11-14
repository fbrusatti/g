/**
 * jQuery Black Calculator
 * @name jquery.calculator.js
 * @description Calculator
 * @author Rafael Carvalho Oliveira - http://www.blackhauz.com.br/
 * @version 1.0
 * @update March 25, 2013
 * @date July 20, 2012
 * @copyright (c) 2012 Rafael Carvalho Oliveira - http://www.blackhauz.com.br/
 * @license Dual licensed under the MIT or GPL Version 2 licenses
 * @example http://blackhauz.com.br/blog/wp-content/examples/black_calculator
 */
(function($)
{
    // ## public functions

    // primary function
    $.fn.blackCalculator = function(options) {
        var settings = $.extend({}, $.fn.blackCalculator.defaults, options);

		// whitelist
		if (settings.type == 'advanced') {
			var whiteList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-', '+', '*', '/', '(', ')', '^', '%'];
		} else {
			var whiteList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-', '+', '*', '/'];
		}

		// put CSS elements in head
		if (!settings.cssManual) {
			var styles = '<link rel="stylesheet" type="text/css" href="' + settings.css + 'black_calculator.css" />';
			styles += '<!--[if lt IE 9]><link rel="stylesheet" type="text/css" href="' + settings.css
			+ 'black_calculator_ie.css" />';
			styles += '<style type="text/css">';
			styles += '.blackCalculator a, .blackCalculator, .blackCalculator form input[type=text] { behavior:url("' + settings.css
			+ 'PIE.htc"); position:relative; }';
			styles += '</style><![endif]-->';

			$('head').append(styles);
		}

    // put itens inside element
    var form = '<form method="post" action="javascript:void(0)" id="blackCalculatorForm">';
    form += '<input type="text" name="blackCalculator" id="blackCalculator" autofocus="autofocus"></form>';

    $(this).addClass('blackCalculator');
    $(this).prepend(form);
		// line 1
		var lines = '<form class="table table-hover"  style="margin-bottom: 4px;">'
		lines += '<div> <a href="javascript:void(0)" title="' + settings.language.backspace
		+ '" class="label label-default" style="width:58px; margin:0; padding: 0px; padding-left: 13px; padding-right: 13px;" rel="<">C</a></div>';

		if (settings.type == 'advanced') {
			lines += '<div><a href="javascript:void(0)" title="' + settings.language.clear + '" rel="c"><span class="label label-default">C</span></a> </div>';
			lines += '<div><a href="javascript:void(0)" title="(" rel="("><span class="label label-default">(</span></a></div>';
			lines += '<div><a href="javascript:void(0)" title=")" rel=")"><span class="label label-default">)</span></a></div>';
		} else {
			lines += '<div><a href="javascript:void(0)" title="' + settings.language.clear + '" class="label label-default" rel="c" style="width:101px; padding: 0px; padding-left: 13px; padding-right: 13px; margin: 10px;">' +
			settings.language.clear + '</a></div>';
		}
		lines += '</form>';

		// line 2
		lines += '<form><div><a href="javascript:void(0)" title="7" class="btn btn-default btn-lg active" style="margin:0;" rel="7"><span>7</span></a></div>';
        lines += '<div><a href="javascript:void(0)" title="8" class="btn btn-default btn-lg active" rel="8"><span>8</span></a></div>';
        lines += '<div><a href="javascript:void(0)" title="9" class="btn btn-default btn-lg active"  rel="9"><span>9</span></a></div>';

		if (settings.type == 'advanced') {
			lines += '<div><a href="javascript:void(0)" title="/" class="btn btn-default btn-lg active" rel="/"><span>/</span></a></div>';
			lines += '<div><a href="javascript:void(0)" title="%" class="btn btn-default btn-lg active" rel="%"><span>%</span></a></div>';
		} else {
			lines += '<div><a href="javascript:void(0)" title="/" class="btn btn-default btn-lg active" rel="/" style="width:57px;"><span>/</span></a></div>';
		}
		lines += '</form>'
		// lines 3
		lines += '<form><div><a href="javascript:void(0)" title="4" class="btn btn-default btn-lg active" style="margin:0;" rel="4"><span>4</span></a></div>';
        lines += '<div><a href="javascript:void(0)" title="5" class="btn btn-default btn-lg active" rel="5"><span>5</span></a></div>';
        lines += '<div><a href="javascript:void(0)" title="6" class="btn btn-default btn-lg active" rel="6"><span>6</span></a></div>';

		if (settings.type == 'advanced') {
			lines += '<div><a href="javascript:void(0)" title="*" class="btn btn-default btn-lg active" rel="*"><span>*</span></a></div>';
			lines += '<div><a href="javascript:void(0)" title="yx" class="btn btn-default btn-lg active" rel="yx"><span>y<sup>x</sup></span></a></div>';
		} else {
			lines += '<div><a href="javascript:void(0)" title="*" class="btn btn-default btn-lg active" rel="*" style="width:57px;"><span>*</span></a></div>';
		}
		lines += '</form>'
		// lines 4
		lines += '<form><div><a href="javascript:void(0)" title="1" class="btn btn-default btn-lg active" style="margin:0;" rel="1"><span>1</span></a></div>';
        lines += '<div><a href="javascript:void(0)" title="2" class="btn btn-default btn-lg active" rel="2"><span>2</span></a></div>';
        lines += '<div><a href="javascript:void(0)" title="3" class="btn btn-default btn-lg active" rel="3"><span>3</span></a></div>';

		if (settings.type == 'advanced') {
			lines += '<div><a href="javascript:void(0)" title="-" class="btn btn-default btn-lg active" rel="-"><span>-</span></a></div>';
		} else {
			lines += '<div><a href="javascript:void(0)" title="-" class="btn btn-default btn-lg active" rel="-" style="width:57px;"><span>-</span></a></div>';
		}

        lines += '</form>'
        lines += '<div class="clear"></div>';
		// lines 5
		if (settings.type == 'advanced') {
			lines += '<form><div><a href="javascript:void(0)" title="0" class="btn btn-default btn-lg active" style="width:58px; margin:0;" rel="0"><span>0</span></a></div>';
		} else {
			lines += '<form><div><a href="javascript:void(0)" title="0" class="btn btn-default btn-lg active" rel="0"	><span>0</span></a></div>';
		}

    lines += '<div><a href="javascript:void(0)" title="," class="btn btn-default btn-lg active" style="width:128px; rel=","><span> , </span></a></div>';

		if (settings.type == 'simple') {
			lines += '<div><a href="javascript:void(0)" title="=" class="btn btn-default btn-lg active" rel="="><span>=</span></a></div>';
		}

		if (settings.type == 'advanced') {
			lines += '<div><a href="javascript:void(0)" title="+" class="btn btn-default btn-lg active" rel="+"><span>+</span></a></div>';
		} else {
			lines += '<div><a href="javascript:void(0)" title="+" class="btn btn-default btn-lg active" rel="+" style="width:57px;"><span>+</span></a></div>';
		}

		if (settings.type == 'advanced') {
			lines += '<a href="javascript:void(0)" title="=" rel="=" style="height:40px; padding-top:35px;' +
			'position:absolute; bottom:1px; class="btn btn-default btn-lg active" right:14px;"><span>=</span></a></div>';
		}
				lines += '</form>'+
				 +'</tbody>'
      +'</table>';
        lines += '<div class="clear"></div>';
		$(this).append(lines);

		// calculator actions
		if (settings.allowKeyboard) {
			$('.blackCalculator').keypress(function(event) {
				var button = String.fromCharCode(event.charCode);
				var code = event.charCode;
				var value = $('#blackCalculator').val();

				// if press enter
				if (code == 13) {
					$('.blackCalculator a[rel="="]').trigger('click');
				} else {
					if (!inArray(whiteList, button)) {
						return false;
					}
				}
			});
		} else {
			$('#blackCalculator').keypress(function(event) {
				return false;
			});
		}

		$('.blackCalculator a').click(function() {
			var button = $(this).attr('rel');
			var value = $('#blackCalculator').val();

			if (inArray(whiteList, button)) {
				$('#blackCalculator').val(value + button);
			} else {
				if (button == 'c') {
					$('#blackCalculator').val(null);
				} else if (button == 'yx') {
					$('#blackCalculator').val(value + '^');
				} else if (button == '<') {
					$('#blackCalculator').val(value.substr(0, value.length - 1));
				} else if (button == '%') {
					$('#blackCalculator').val(value + '%');
				} else if (button == ',') {
					$('#blackCalculator').val(value + '.');
				} else if (button == '=') {
					try {
						// ^ replaced with Math.pow
						var powPattern = /\d+\^\d+/;
						while (strpos(value, '^', 0)) {
							if (powPattern.test(value)) {
								var elements = String(value.match(powPattern));
								var numbers = elements.split('^');

								value = value.replace(powPattern, Math.pow(numbers[0], numbers[1]));
							} else {
								break;
							}
						}

						// % replaced with percent
						var percentPattern = /\d+\*\d+\%/;
						while (strpos(value, '%', 0)) {
							if (percentPattern.test(value)) {
								var elements = String(value.match(percentPattern));
								var numbers = elements.split('*');
								numbers[1] = numbers[1].replace('%', '');

								value = value.replace(percentPattern, numbers[0] * (numbers[1] / 100));
							} else {
								break;
							}
						}

						percentPattern = /\d+\+\d+\%/;
						while (strpos(value, '%', 0)) {
							if (percentPattern.test(value)) {
								var elements = String(value.match(percentPattern));
								var numbers = elements.split('+');
								numbers[1] = numbers[1].replace('%', '');

								value = value.replace(percentPattern, parseFloat(numbers[0]) + (numbers[0] * (numbers[1] / 100)));
							} else {
								break;
							}
						}

						percentPattern = /\d+\-\d+\%/;
						while (strpos(value, '%', 0)) {
							if (percentPattern.test(value)) {
								var elements = String(value.match(percentPattern));
								var numbers = elements.split('-');
								numbers[1] = numbers[1].replace('%', '');

								value = value.replace(percentPattern, parseFloat(numbers[0]) - (numbers[0] * (numbers[1] / 100)));
							} else {
								break;
							}
						}

						percentPattern = /\d+\/\d+\%/;
						while (strpos(value, '%', 0)) {
							if (percentPattern.test(value)) {
								var elements = String(value.match(percentPattern));
								var numbers = elements.split('/');
								numbers[1] = numbers[1].replace('%', '');

								value = value.replace(percentPattern, numbers[0] / (numbers[1] / 100));
							} else {
								break;
							}
						}

						$('#blackCalculator').val(eval(value));
					} catch (err) {
						alert("Error Expresion no Valida");
					}
				}
			}
		});

        return this;
    };

    $.fn.blackCalculator.defaults = {
        type: 'simple',
        allowKeyboard: false,
		cssManual: false,
		css: 'css/',
        language: {
            value: 'Value',
            backspace: 'Backspace',
            clear: 'Clear'
        }
    };

    // ## private functions

	// http://phpjs.org/functions/in_array:432
	function inArray(haystack, needle)
    {
		var length = haystack.length;
		for(var i = 0; i < length; i++) {
			if(haystack[i] == needle) return true;
		}
		return false;
	};

	// http://phpjs.org/functions/strpos:545
	function strpos(haystack, needle, offset)
    {
		var i = (haystack + '').indexOf(needle, (offset || 0));
		return i === -1 ? false : i;
	};
})(jQuery);
