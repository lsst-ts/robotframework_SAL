*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 4 205 41 245 202 89 45 41 27 249 51 18 207 184 33 109 58 220 255 149 138 226 163 55 153 207 207 75 27 160 217 124 62 229 98 73 145 113 13 200 3 224 74 140 219 13 27 140 148 71 200 247 111 220 111 10 37 25 208 66 83 39 225 4 166 224 25 108 228 49 233 192 252 170 63 95 96 49 202 114 170 147 74 30 145 151 81 117 188 212 67 81 92 242 254 164 98 71 34 241 205 127 172 192 207 213 15 108 39 228 104 104 250 82 246 17 193 196 242 137 84 216 36 60 186 148 186 47 244 226 63 137 133 185 90 118 4 163 85 252 161 14 81 83 93 137 182 40 152 75 111 153 86 68 51 103 49 8 17 192 255 206 190 134 21 76 167 215 23 154 130 128 250 223 166 141 180 72 115 232 191 95 92 34 227 75 193 105 170 216 156 158 176 43 119 179 189 214 122 238 112 30 209 198 52 108 212 137 73 82 107 170 62 170 123 163 4 133 149 143 148 121 40 24 18 58 250 121 90 63 115 70 252 114 108 95 196 184 213 146 241 79 128 128 26 96 250 126 158 7 238 222 180 242 47 147 225 180 155 219 47 156 78 231 155 78 57 156 65 159 166 157 239 203 252 141 247 88 57 226 138 137 6 88 66 153 76 35 237 122 101 200 166 128 250 254 255 218 160 214 162 54 251 53 122 153 144 64 206 224 112 178 122 116 91 155 213 66 226 94 72 74 143 66 122 198 26 215 104 54 8 247 223 130 159 12 72 1 48 63 89 78 44 128 126 213 156 178 220 19 216 14 125 18 132 93 125 191 251 234 185 190 156 39 61 37 235 21 34 163 53 216 197 223 172 91 115 115 156 3 133 248 211 186 104 57 232 122 167 161 184 171 199 30 210 33 177 20 216 125 249 13 106 217 13 249 132 36 57 27 139 57 212 200 235 147 239 73 244 102 219 196 15 111 157 76 107 80 61 193 69 37 2 141 179 171 193 136 66 61 41 216 60 216 199 197 32 117 251 208 109 93 88 92 1 126 45 79 253 254 128 63 206 134 83 247 170 65 124 205 206 228 43 148 91 188 197 168 169 154 153 75 65 93 125 175 105 127 39 158 247 181 34 103 74 180 170 89 204 150 175 157 49 38 10 219 183 174 108 148 208 193 51 228 75 208 221 55 165 207 96 118 188 59 202 8 126 0 95 199 57 201 190 74 214 143 38 6 95 245 209 121 181 184 16 186 171 159 101 59 19 155 235 151 2 156 224 0 243 95 210 75 15 96 195 106 140 162 123 31 230 74 209 61 246 40 82 85 248 144 69 227 244 39 220 93 122 184 112 116 186 191 94 131 51 164 180 225 67 210 41 239 74 104 35 182 217 128 172 134 158 155 142 139 100 40 100 88 230 0 60 213 45 176 155 184 232 188 240 174 73 27 225 211 13 85 29 102 79 174 129 194 149 11 228 165 11 16 0 140 0 187 22 98 6 219 49 244 110 95 152 137 213 47 11 248 204 209 194 38 253 214 15 226 144 102 245 234 171 140 165 160 234 248 53 142 134 66 94 96 243 0 127 253 51 252 216 79 210 110 34 73 105 218 52 40 231 159 212 91 75 31 139 152 156 186 50 196 254 253 205 47 114 209 48 160 213 94 254 227 76 144 62 186 93 15 66 140 1 181 141 64 58 234 111 133 45 42 72 12 237 228 138 184 42 59 4 111 164 198 136 97 85 113 183 49 6 112 36 241 161 205 203 162 255 146 157 149 23 184 187 54 71 13 215 145 128 105 142 84 99 204 159 25 148 104 185 116 158 37 159 236 55 135 42 166 57 2 22 10 160 66 116 214 177 61 40 21 121 10 110 106 205 203 118 194 97 168 140 131 248 128 3 226 132 40 145 252 0 17 79 237 231 182 66 174 113 167 153 175 80 171 193 5 122 10 177 116 183 126 86 170 35 45 124 32 115 239 203 255 138 159 2 73 221 193 183 100 206 201 237 65 211 191 171 46 13 247 181 229 187 149 97 1 248 240 54 175 212 221 234 179 227 9 77 116 30 200 246 137 48 180 220 112 221 126 26 42 186 49 125 67 142 95 145 150 241 94 175 42 7 120 20 123 76 86 37 215 178 105 173 135 185 119 112 65 65 208 203 146 46 112 213 166 29 161 225 182 208 101 18 11 1 120 42 124 62 213 103 66 76 254 57 164 179 80 49 156 181 83 82 18 22 62 91 223 186 148 167 103 220 66 193 255 58 227 117 19 188 127 -1378239409
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
