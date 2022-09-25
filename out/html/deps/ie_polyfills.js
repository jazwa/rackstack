if (!String.prototype.repeat) {
  String.prototype.repeat = function(count) {
    'use strict';
    if (this == null) {
      throw new TypeError('can\'t convert ' + this + ' to object');
    }
    var str = '' + this;
    count = +count;
    if (count != count) {
      count = 0;
    }
    if (count < 0) {
      throw new RangeError('repeat count must be non-negative');
    }
    if (count == Infinity) {
      throw new RangeError('repeat count must be less than infinity');
    }
    count = Math.floor(count);
    if (str.length == 0 || count == 0) {
      return '';
    }
    // Ensuring count is a 31-bit integer allows us to heavily optimize the
    // main part. But anyway, most current (August 2014) browsers can't handle
    // strings 1 << 28 chars or longer, so:
    if (str.length * count >= 1 << 28) {
      throw new RangeError('repeat count must not overflow maximum string size');
    }
    var rpt = '';
    for (;;) {
      if ((count & 1) == 1) {
        rpt += str;
      }
      count >>>= 1;
      if (count == 0) {
        break;
      }
      str += str;
    }
    // Could we try:
    // return Array(count + 1).join(this);
    return rpt;
  }
}

'use strict';(function(e){function r(b){var a=b.charCodeAt(0),c=1114112,d=0,n=b.length|0,g="";switch(a>>>4){case 12:case 13:c=(a&31)<<6|b.charCodeAt(1)&63;d=128>c?0:2;break;case 14:c=(a&15)<<12|(b.charCodeAt(1)&63)<<6|b.charCodeAt(2)&63;d=2048>c?0:3;break;case 15:30===a>>>3&&(c=(a&7)<<18|(b.charCodeAt(1)&63)<<12|(b.charCodeAt(2)&63)<<6|b.charCodeAt(3),d=65536>c?0:4)}d&&(n<d?d=0:65536>c?g=f(c):1114112>c?(c=c-65664|0,g=f((c>>>10)+55296|0,(c&1023)+56320|0)):d=0);for(;d<n;d=d+1|0)g+="\ufffd";return g}
function p(){}function t(b){var a=b.charCodeAt(0)|0;if(55296<=a&&56319>=a)if(b=b.charCodeAt(1)|0,56320<=b&&57343>=b){if(a=(a<<10)+b-56613888|0,65535<a)return f(240|a>>>18,128|a>>>12&63,128|a>>>6&63,128|a&63)}else a=65533;return 2047>=a?f(192|a>>>6,128|a&63):f(224|a>>>12,128|a>>>6&63,128|a&63)}function q(){}var f=String.fromCharCode,l={}.toString,h=e.SharedArrayBuffer,u=h?l.call(h):"",k=e.Uint8Array,m=k||Array,v=l.call((k?ArrayBuffer:m).prototype);h=q.prototype;var w=e.TextEncoder;p.prototype.decode=
function(b){var a=b&&b.buffer||b,c=l.call(a);if(c!==v&&c!==u&&void 0!==b)throw TypeError("Failed to execute 'decode' on 'TextDecoder': The provided value is not of type '(ArrayBuffer or ArrayBufferView)'");b=k?new m(a):a;a="";c=0;for(var d=b.length|0;c<d;c=c+32768|0)a+=f.apply(0,b[k?"subarray":"slice"](c,c+32768|0));return a.replace(/[\xc0-\xff][\x80-\xbf]+|[\x80-\xff]/g,r)};e.TextDecoder||(e.TextDecoder=p);h.encode=function(b){b=void 0===b?"":(""+b).replace(/[\x80-\uD7ff\uDC00-\uFFFF]|[\uD800-\uDBFF][\uDC00-\uDFFF]?/g,
t);for(var a=b.length|0,c=new m(a),d=0;d<a;d=d+1|0)c[d]=b.charCodeAt(d);return c};w||(e.TextEncoder=q)})(""+void 0==typeof global?""+void 0==typeof self?this:self:global);//AnonyCo
