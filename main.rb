require "chunky_png"

input_files = Dir.glob("input/*.png")

input_files.each do |file|
    if File.file?(file) and File.extname(file) == ".png"
        white_pixels = 0
        total_pixels = 0

        File.open(file, 'rb') do |io|
            image = ChunkyPNG::Image.from_io(io)

            total_pixels = image.height * image.width

            image.pixels.map! do |pixel|
                white_pixels += 1 if ChunkyPNG::Color.r(pixel) == 255 and ChunkyPNG::Color.g(pixel) == 255 and ChunkyPNG::Color.b(pixel) == 255
            end
        end

        output_file = "output/#{File.basename(file)}.md"
        File.open(output_file, "w") do |out_file|
            out_file.puts "#{File.basename(file)}\n#{"=" * file.length}\n![#{File.basename(file)}](../#{file})\n\n__Total pixels:__ #{total_pixels}\n\n__White pixels:__ #{white_pixels}\n\n__Pixels other:__ #{total_pixels - white_pixels}"
        end
    end
end
