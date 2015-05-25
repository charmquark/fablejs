Gem::Specification.new do |s|
    s.name          = 'fable_js'
    s.version       = '0.0.1'
    s.homepage      = 'https://github.com/csauls/fablejs'
    s.license       = 'MIT'

    s.summary       = ''

    s.description   = ''

    s.date          = Time.now.strftime '%Y-%m-%d'

    s.authors       = [
        'Christopher Nicholson-Sauls'
    ]
    s.email         = 'ibisbasenji@gmail.com'

    s.files         = Dir[
        File.join('bin', '*'),
        File.join('lib', '**', '*.rb')
    ]
    s.executables   << 'fable-js'
end