class Chord < Music
  
  BARRE_CHORDS = {
    'full' => {
      'major' => ['0', '2', '2', '1', '0', '0'],
      'minor' => ['0', '2', '2', '0', '0', '0'],
      'dom7' => ['0', '2', '0', '1', '3', '0'],
      'major7' => ['0', 'X', '1', '1', '0', 'X'],
      'minor7' => ['0', '2', '0', '0', '0', '0']
    },
    'half' => {
      'major' => ['X', '0', '2', '2', '2', '0'],
      'minor' => ['X', '0', '2', '2', '1', '0']
    }
  }
  
  STRINGS = {
    6 => {
      'sharp' => ['E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B', 'C', 'C#', 'D', 'D#'],
      'flat' => ['E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb']
    },
    5 => {
      'sharp' => ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#'],
      'flat' => ['A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab']
    }
  }
  
  # @note String
  #   - The root note of the chord. Ex. 'A' or 'C'
  # 
  # @accidental String
  #   - Natural, sharp, flat
  # 
  # @type String
  #   - Chord type: major, minor, dom7, etc..
  
  def initialize params
    @note = params[:note]
    @accidental = params[:accidental]
    @type = params[:type]
    @notes = @accidental == 'flat' || symbol_name == 'F' ? NOTES_FLAT : NOTES_SHARP
  end
  
  def name
    "#{symbol_name} #{@type}"
  end
  
  def symbol_name
    @note + get_accidental_symbol_from_name(@accidental)
  end
  
  def get_notes
    notes = Array.new
    scale = get_major_scale(symbol_name, @accidental, @notes)
    CHORD_TYPES[@type].each do |interval|
      case interval[0]
      when 'b'
        major_note = scale[interval[1].to_i]
        index = NOTES_FLAT.rindex(major_note) || NOTES_FLAT.rindex(NOTE_ALIASES[major_note])
        notes << NOTES_FLAT[index - 1]
      when '#'
        
      else
        notes << scale[interval.to_i]
      end
    end
    notes
  end
  
  def get_barre_large
    strings = @accidental == 'flat' ? STRINGS[6]['flat'] : STRINGS[6]['sharp']
    fret = strings.index symbol_name
    
    chord_chart = Hash.new
    chord_chart['root'] = fret
    chord_chart['notes'] = BARRE_CHORDS['full'][@type].map { |value| value == 'X' ? 'X' : value.to_i + fret }
    ap chord_chart
    chord_chart
  end
  
  def get_barre_small
    
  end
  
end