"""autogenerated by genpy from comunicacion_serial/ComandoMovimiento.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class ComandoMovimiento(genpy.Message):
  _md5sum = "b4b940224c0de969ca5cc85632c6b706"
  _type = "comunicacion_serial/ComandoMovimiento"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """int16 comandoPitch
int16 comandoRoll
int16 comandoAltura

"""
  __slots__ = ['comandoPitch','comandoRoll','comandoAltura']
  _slot_types = ['int16','int16','int16']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       comandoPitch,comandoRoll,comandoAltura

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(ComandoMovimiento, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.comandoPitch is None:
        self.comandoPitch = 0
      if self.comandoRoll is None:
        self.comandoRoll = 0
      if self.comandoAltura is None:
        self.comandoAltura = 0
    else:
      self.comandoPitch = 0
      self.comandoRoll = 0
      self.comandoAltura = 0

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_struct_3h.pack(_x.comandoPitch, _x.comandoRoll, _x.comandoAltura))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(_x))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(_x))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      end = 0
      _x = self
      start = end
      end += 6
      (_x.comandoPitch, _x.comandoRoll, _x.comandoAltura,) = _struct_3h.unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_struct_3h.pack(_x.comandoPitch, _x.comandoRoll, _x.comandoAltura))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(_x))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(_x))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      end = 0
      _x = self
      start = end
      end += 6
      (_x.comandoPitch, _x.comandoRoll, _x.comandoAltura,) = _struct_3h.unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
_struct_3h = struct.Struct("<3h")
