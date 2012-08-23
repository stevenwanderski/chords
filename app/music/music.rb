class Music
  
  FULL_STEP = 2
  HALF_STEP = 1
  
  MAJOR_SCALE_STEPS = [FULL_STEP, FULL_STEP, HALF_STEP, FULL_STEP, FULL_STEP, FULL_STEP, HALF_STEP]
  # MAJOR_SCALE_STEPS = [0, 2, 4, 5, 7, 9, 11]
  
  CIRCLE_OF_FIFTHS = {
    'C' => {
      'type' => 'none',
      'accidentals' => []
    },
    'G' => {
      'type' => 'sharp',
      'accidentals' => ['F']
    },
    'D' => {
      'type' => 'sharp',
      'accidentals' => ['F', 'C']
    },
    'A' => {
      'type' => 'sharp',
      'accidentals' => ['F', 'C', 'G']
    },
    'E' => {
      'type' => 'sharp',
      'accidentals' => ['F', 'C', 'G', 'D']
    },
    'B' => {
      'type' => 'sharp',
      'accidentals' => ['F', 'C', 'G', 'D', 'A']
    },
    'F#' => {
      'type' => 'sharp',
      'accidentals' => ['F', 'C', 'G', 'D', 'A', 'E']
    },
    'F' => {
      'type' => 'flat',
      'accidentals' => ['B']
    },
    'Bb' => {
      'type' => 'flat',
      'accidentals' => ['B', 'E']
    },
    'Eb' => {
      'type' => 'flat',
      'accidentals' => ['B', 'E', 'A']
    },
    'Ab' => {
      'type' => 'flat',
      'accidentals' => ['B', 'E', 'A', 'D']
    },
    'Db' => {
      'type' => 'flat',
      'accidentals' => ['B', 'E', 'A', 'D', 'G']
    },
    'Gb' => {
      'type' => 'flat',
      'accidentals' => ['B', 'E', 'A', 'D', 'G', 'C']
    }
  }
  
  NOTES = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#']
  
  NOTES_SHARP = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#']
  NOTES_FLAT = ['A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab']
  
  NOTE_ALIASES = {
    'A#' => 'Bb',
    'C#' => 'Db',
    'D#' => 'Eb',
    'F#' => 'Gb',
    'G#' => 'Ab'
  }
  
  CHORD_TYPES = {
    'major' => ['1', '3', '5'],
    'minor' => ['1', 'b3', '5'],
    'dom7' =>  ['1', '3', '5', 'b7'],
    'major7' =>  ['1', '3', '5', '7'],
    'minor7' =>  ['1', 'b3', '5', 'b7']
  }
  
  CHORD_TYPE_LOOKUP = {
    'm' => 'minor',
    'M' => 'major',
    '7' => 'dom7',
    'M7' => 'major7',
    'm7' => 'minor7'
  }
  
  def get_major_scale(symbol_name, accidental, notes)
    
    major_scale = Hash.new
    index = 1
    
    start = notes.index symbol_name
    
    MAJOR_SCALE_STEPS.each do |step|
      major_scale[index] = notes[start]
      start += step
      index += 1
    end

    major_scale
  end
  
  def sharpen_note(note, scale_type)
    note_type = /#/.match(note) ? 'sharp' : 'flat'
    index = @notes[scale_type].index note
    if index + 1 > @notes[note_type].length - 1
      @notes[scale_type][0]
    else
      @notes[scale_type][index + 1]
    end
  end
  
  def flatten_note(note)
    case note
    when 'C'
      'B'
    when 'F'
      'E'
    when /^[A-Z]\#$/
      note.gsub(/\#/, '')
    else
      "#{note}b"
    end
  end
  
  def get_accidental_symbol_from_name(name)
    symbol = ''
    if name == 'sharp'
      symbol = '#'
    elsif name == 'flat'
      symbol = 'b'
    end
    symbol
  end
  
end